import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lavalink/src/connection.dart';
import 'package:lavalink/src/errors.dart';
import 'package:lavalink/src/models/filters.dart';
import 'package:lavalink/src/models/info.dart';
import 'package:lavalink/src/models/loaded_track_result.dart';
import 'package:lavalink/src/models/player.dart';
import 'package:lavalink/src/models/route_planner.dart';
import 'package:lavalink/src/models/stats.dart';
import 'package:lavalink/src/models/track.dart';

class LavalinkClient {
  static const version = '1.0.0';
  static const defaultClientName = 'Dart-Lavalink/$version';

  final Uri base;
  final String password;
  final String userId;
  final String clientName;

  final http.Client httpClient = http.Client();
  LavalinkConnection get connection => _connection;
  late final LavalinkConnection _connection;

  LavalinkClient._({
    required this.base,
    required this.password,
    required this.userId,
    required this.clientName,
  });

  static Future<LavalinkClient> connect(
    Uri base, {
    required String password,
    required String userId,
    String clientName = defaultClientName,
  }) async {
    // Ensure the path will be used as a directory in resolve()
    if (!base.path.endsWith('/')) base = base.replace(path: '${base.path}/');

    final client = LavalinkClient._(
      base: base,
      password: password,
      userId: userId,
      clientName: clientName,
    );

    client._connection = await LavalinkConnection.connect(client);

    return client;
  }

  Future<String> _executeSafe(
    String method,
    String endpoint, {
    bool trace = false,
    Object? body,
    Map<String, String>? queryParameters,
  }) async {
    // Avoid resetting the path of the base URI
    if (endpoint.startsWith('/')) endpoint = endpoint.substring(1);

    final uri = base.resolveUri(Uri(
      path: endpoint,
      queryParameters: {
        if (trace) 'trace': 'true',
        ...?queryParameters,
      },
    ));

    final request = http.Request(method, uri)
      ..headers['Authorization'] = password
      ..headers['Content-Type'] = 'application/json';
    if (body != null) request.bodyBytes = utf8.encode(jsonEncode(body));

    final response = await http.Response.fromStream(await httpClient.send(request));
    final bodyText = utf8.decode(response.bodyBytes);

    if (response.statusCode >= 400) {
      final parsedBody = jsonDecode(bodyText);

      throw LavalinkException(
        timestamp: DateTime.fromMicrosecondsSinceEpoch(parsedBody['timestamp'] as int),
        status: parsedBody['status'] as int,
        error: parsedBody['error'] as String,
        trace: parsedBody['trace'] as String?,
        message: parsedBody['message'] as String,
        path: parsedBody['path'] as String,
      );
    }

    return bodyText;
  }

  Future<List<Player>> listPlayers() async {
    final response =
        jsonDecode(await _executeSafe('GET', '/v4/sessions/${connection.sessionId}/players'));
    return (response as List).cast<Map<String, Object?>>().map(Player.fromJson).toList();
  }

  Future<Player> getPlayer(String guildId) async {
    final response = jsonDecode(await _executeSafe(
      'GET',
      '/v4/sessions/${connection.sessionId}/players/$guildId',
    ));
    return Player.fromJson(response as Map<String, Object?>);
  }

  Future<Player> updatePlayer(
    String guildId, {
    bool? noReplace,
    String? encodedTrack = _sentinelString,
    String? identifier,
    Duration? position,
    Duration? endTime = _sentinelDuration,
    int? volume,
    bool? isPaused,
    Filters? filters,
    VoiceState? voice,
  }) async {
    final response = jsonDecode(await _executeSafe(
      'PATCH',
      '/v4/sessions/${connection.sessionId}/players/$guildId',
      body: {
        if (!identical(encodedTrack, _sentinelString)) 'encodedTrack': encodedTrack,
        if (identifier != null) 'identifier': identifier,
        if (position != null) 'position': position.inMilliseconds,
        if (!identical(endTime, _sentinelDuration)) 'endTime': endTime?.inMilliseconds,
        if (volume != null) 'volume': volume,
        if (isPaused != null) 'paused': isPaused,
        if (filters != null) 'filters': filters.toJson(),
        if (voice != null) 'voice': voice.toJson(),
      },
    ));
    return Player.fromJson(response as Map<String, Object?>);
  }

  Future<void> deletePlayer(String guildId) async {
    await _executeSafe('DELETE', '/v4/sessions/${connection.sessionId}/players/$guildId');
  }

  Future<({bool resuming, Duration timeout})> updateSession({
    bool? resuming,
    Duration? timeout,
  }) async {
    final response = jsonDecode(await _executeSafe(
      'PATCH',
      '/v4/sessions/${connection.sessionId}',
      body: {
        if (resuming != null) 'resuming': resuming,
        if (timeout != null) 'timeout': timeout.inSeconds,
      },
    )) as Map<String, Object?>;

    return (
      resuming: response['resuming'] as bool,
      timeout: Duration(seconds: response['timeout'] as int),
    );
  }

  Future<LoadResult> loadTrack(String identifier) async {
    final response = jsonDecode(await _executeSafe(
      'GET',
      '/v4/loadtracks',
      queryParameters: {'identifier': identifier},
    ));
    return LoadResult.fromJson(response as Map<String, Object?>);
  }

  Future<Track> decodeTrack(String encodedTrack) async {
    final response = jsonDecode(await _executeSafe(
      'GET',
      '/v4/decodetrack',
      queryParameters: {'encodedTrack': encodedTrack},
    ));
    return Track.fromJson(response as Map<String, Object?>);
  }

  Future<List<Track>> decodeTracks(List<String> encodedTracks) async {
    final response =
        jsonDecode(await _executeSafe('POST', '/v4/decodetracks', body: encodedTracks));
    return (response as List).cast<Map<String, Object?>>().map(Track.fromJson).toList();
  }

  Future<LavalinkInfo> getInfo() async {
    final response = jsonDecode(await _executeSafe('GET', '/v4/info'));
    return LavalinkInfo.fromJson(response as Map<String, Object?>);
  }

  Future<LavalinkStats> getStats() async {
    final response = jsonDecode(await _executeSafe('GET', '/v4/stats'));
    return LavalinkStats.fromJson(response as Map<String, Object?>);
  }

  Future<String> getVersion() async => await _executeSafe('GET', '/version');

  Future<RoutePlannerStatus> getRoutePlannerStatus() async {
    final response = jsonDecode(await _executeSafe('GET', '/v4/routeplanner/status'));
    return RoutePlannerStatus.fromJson(response as Map<String, Object?>);
  }

  Future<void> unmarkFailedAddress(String address) async {
    jsonDecode(await _executeSafe(
      'POST',
      '/v4/routeplanner/free/address',
      body: {'address': address},
    ));
  }

  Future<void> unmarkAllFailedAddresses() async =>
      await _executeSafe('POST', '/v4/routeplanner/free/all');

  Future<void> close() async {
    httpClient.close();
    await connection.close();
  }
}

const _sentinelString = '\u{1B}nyxx_lavalink';
const _sentinelDuration = _SentinelDuration();

class _SentinelDuration implements Duration {
  const _SentinelDuration();

  @override
  void noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

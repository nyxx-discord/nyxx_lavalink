import 'dart:collection';
import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/src/http_exception.dart';
import 'package:nyxx_lavalink/src/model/play_parameters.dart';
import 'package:nyxx_lavalink/src/model/search_platform.dart';
import 'package:nyxx_lavalink/src/model/track_end.dart';
import 'package:nyxx_lavalink/src/node/node_options.dart';
import 'package:nyxx_lavalink/src/model/guild_player.dart';
import 'package:nyxx_lavalink/src/model/stats.dart';
import 'package:nyxx_lavalink/src/model/track.dart';
import 'package:nyxx_lavalink/src/cluster.dart';

abstract class INode {
  /// Node options, such as host, port, etc..
  NodeOptions get options;

  /// Returns a map with all the players the node currently has
  UnmodifiableMapView<Snowflake, IGuildPlayer> get players;

  /// Returns the last stats received by this node
  IStatsEvent? get stats;

  /// Destroys a player
  void destroy(Snowflake guildId);

  /// Stops a player
  void stop(Snowflake guildId);

  /// Skips a track, starting the next one if available or stopping the player if not
  void skip(Snowflake guildId);

  /// Set the pause state of a player
  ///
  /// this method is internally used by [resume] and [pause]
  void setPause(Snowflake guildId, bool pauseState);

  /// Seeks for a given time at the currently playing track
  void seek(Snowflake guildId, Duration time);

  /// Sets the volume for a guild player, [volume] should be a number between 1 to 1000
  void volume(Snowflake guildId, int volume);

  /// Pauses a guild player
  void pause(Snowflake guildId);

  /// Resumes the track playback of a guild player
  void resume(Snowflake guildId);

  /// Searches a given query over the lavalink api and returns the results
  Future<ITracks> searchTracks(String query);

  /// Searches a provided query on selected platform (YouTube by default),
  /// if the query is a link it's searched directly by the link
  Future<ITracks> autoSearch(
    String query, {
    SearchPlatform platform = SearchPlatform.youtube,
  });

  /// Get the [PlayParameters] object for a specific track
  IPlayParameters play(Snowflake guildId, ITrack track,
      {bool replace = false, Duration startTime = const Duration(), Duration? endTime, Snowflake? requester, Snowflake? channelId});

  /// Shuts down the node
  void shutdown();

  /// Create a new player for a specific guild
  IGuildPlayer createPlayer(Snowflake guildId);

  /// Updates the [NodeOptions] property of the node, also reconnects the
  /// websocket to the new options
  void updateOptions(NodeOptions newOptions);

  /// Tells the node to disconnect from lavalink server
  void disconnect();

  /// Tells the node to reconnect to lavalink server
  void reconnect();
}

/// Represents an active and running lavalink node
class Node implements INode {
  /// Node options, such as host, port, etc..
  @override
  NodeOptions options;

  /// A map with guild ids as keys and players as values
  final Map<Snowflake, GuildPlayer> _players = {};

  /// Returns a map with all the players the node currently has
  @override
  UnmodifiableMapView<Snowflake, IGuildPlayer> get players => UnmodifiableMapView(_players);

  /// Returns the last stats received by this node
  @override
  IStatsEvent? stats;

  /// Http client used with this node
  final Client _httpClient = Client();

  final SendPort _nodeSendPort;
  late String _httpUri;
  late Map<String, String> _defaultHeaders;
  final ICluster _cluster;

  /// A regular expression to avoid searching when a link is provided
  final RegExp _urlRegex = RegExp(r"https?://(?:www\.)?.+");

  /// Build a new Node
  Node.fromOptions(this._cluster, this.options, this._nodeSendPort) {
    _httpUri = options.ssl ? "https://${options.host}:${options.port}" : "http://${options.host}:${options.port}";

    _defaultHeaders = {"Authorization": options.password, "Num-Shards": options.shards.toString(), "User-Id": options.clientId.toString()};
  }

  void sendPayload(String op, Snowflake guildId, [Map<String, dynamic>? data]) async {
    if (data == null) {
      _nodeSendPort.send({
        "cmd": "SEND",
        "data": {
          "op": op,
          "guildId": guildId.toString(),
        }
      });
    } else {
      _nodeSendPort.send({
        "cmd": "SEND",
        "data": {"op": op, "guildId": guildId.toString(), ...data}
      });
    }
  }

  void playNext(Snowflake guildId) async {
    final player = _players[guildId];

    if (player == null) {
      return;
    }

    final track = player.queue.first;

    player.nowPlaying = track;

    if (track.endTime == null) {
      sendPayload("play", guildId, {
        "track": track.track.track,
        "noReplace": false,
        "startTime": track.startTime.inMilliseconds,
      });
    } else {
      sendPayload("play", guildId,
          {"track": track.track.track, "noReplace": false, "startTime": track.startTime.inMilliseconds, "endTime": track.endTime!.inMilliseconds});
    }
  }

  void handleTrackEnd(ITrackEndEvent event) {
    if (!(event.reason == "FINISHED")) {
      return;
    }

    final player = _players[event.guildId];

    if (player == null) {
      return;
    }

    player.queue.removeAt(0);
    player.nowPlaying = null;

    if (player.queue.isEmpty) {
      return;
    }

    playNext(event.guildId);
  }

  /// Destroys a player
  @override
  void destroy(Snowflake guildId) {
    sendPayload("destroy", guildId);

    // delete the actual player
    _players.remove(guildId);

    // delete the relationship between this node and the player so
    // if this guild creates a new player, it can be assigned to other node
    (_cluster as Cluster).nodeLocations.remove(guildId);
  }

  /// Stops a player
  @override
  void stop(Snowflake guildId) {
    final player = _players[guildId];

    if (player == null) {
      return;
    }

    player.queue.clear();
    player.nowPlaying = null;

    sendPayload("stop", guildId);
  }

  /// Skips a track, starting the next one if available or stopping the player if not
  @override
  void skip(Snowflake guildId) {
    final player = _players[guildId];

    if (player == null) {
      return;
    }

    if (player.queue.isEmpty) {
      return;
    } else if (player.queue.length == 1) {
      stop(guildId);
      return;
    } else {
      player.queue.removeAt(0);
      playNext(guildId);
    }
  }

  /// Set the pause state of a player
  ///
  /// this method is internally used by [resume] and [pause]
  @override
  void setPause(Snowflake guildId, bool pauseState) {
    sendPayload("pause", guildId, {"pause": pauseState});
  }

  /// Seeks for a given time at the currently playing track
  @override
  void seek(Snowflake guildId, Duration time) {
    sendPayload("seek", guildId, {"position": time.inMilliseconds});
  }

  /// Sets the volume for a guild player, [volume] should be a number between 1 to 1000
  @override
  void volume(Snowflake guildId, int volume) {
    final trimmed = volume.clamp(0, 1000);

    sendPayload("volume", guildId, {"volume": trimmed});
  }

  /// Pauses a guild player
  @override
  void pause(Snowflake guildId) {
    setPause(guildId, true);
  }

  /// Resumes the track playback of a guild player
  @override
  void resume(Snowflake guildId) {
    setPause(guildId, false);
  }

  /// Searches a given query over the lavalink api and returns the results
  @override
  Future<Tracks> searchTracks(String query) async {
    final response = await _httpClient.get(Uri.parse("$_httpUri/loadtracks?identifier=$query"), headers: _defaultHeaders);

    if (!(response.statusCode == 200)) {
      throw HttpException(response.statusCode);
    }

    return Tracks(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// Searches a provided query on selected platform (YouTube by default),
  /// if the query is a link it's searched directly by the link
  @override
  Future<Tracks> autoSearch(
    String query, {
    SearchPlatform platform = SearchPlatform.youtube,
  }) async {
    if (_urlRegex.hasMatch(query)) {
      return searchTracks(query);
    }

    return searchTracks("${platform.value}:$query");
  }

  /// Get the [PlayParameters] object for a specific track
  @override
  IPlayParameters play(Snowflake guildId, ITrack track,
          {bool replace = false, Duration startTime = const Duration(), Duration? endTime, Snowflake? requester, Snowflake? channelId}) =>
      PlayParameters(this, track, guildId, replace, startTime, endTime, requester, channelId);

  /// Shuts down the node
  @override
  void shutdown() {
    _nodeSendPort.send({"cmd": "SHUTDOWN"});
  }

  /// Create a new player for a specific guild
  @override
  IGuildPlayer createPlayer(Snowflake guildId) {
    final player = GuildPlayer(this, guildId);

    _players[guildId] = player;
    (_cluster as Cluster).nodeLocations[guildId] = options.nodeId;

    return player;
  }

  /// Updates the [NodeOptions] property of the node, also reconnects the
  /// websocket to the new options
  @override
  void updateOptions(NodeOptions newOptions) {
    // Set the node id and client id before sending it to the isolate
    newOptions.clientId = options.clientId;
    newOptions.nodeId = options.nodeId;

    _nodeSendPort.send({"cmd": "UPDATE", "data": newOptions.toJson()});

    options = newOptions;
  }

  /// Tells the node to disconnect from lavalink server
  @override
  void disconnect() {
    _nodeSendPort.send({"cmd": "DISCONNECT"});
  }

  /// Tells the node to reconnect to lavalink server
  @override
  void reconnect() {
    _nodeSendPort.send({"cmd": "RECONNECT"});
  }
}

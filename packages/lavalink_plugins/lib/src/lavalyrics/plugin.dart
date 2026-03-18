import 'dart:convert';

import 'package:lavalink/lavalink.dart';
import 'package:lavalink_plugins/src/lavalyrics/models/events/lyrics_found_event.dart';
import 'package:lavalink_plugins/src/lavalyrics/models/events/lyrics_line_event.dart';
import 'package:lavalink_plugins/src/lavalyrics/models/events/lyrics_not_found_event.dart';
import 'package:lavalink_plugins/src/lavalyrics/models/lyrics.dart';

class LavaLyricsPlugin extends LavalinkExternalPlugin {
  @override
  String get name => 'LavaLyrics';

  @override
  final Map<String, LavalinkExternalPluginEventHandler> handledEvents = {
    'LyricsFoundEvent': LyricsFoundEvent.fromJson,
    'LyricsNotFoundEvent': LyricsNotFoundEvent.fromJson,
    'LyricsLineEvent': LyricsLineEvent.fromJson,
  };

  LavaLyricsPlugin(super.client);

  /// Gets the lyrics of the current playing track. By default, it will try to fetch the lyrics from where the track is sourced from.
  /// E.g. if the track is from Deezer it will try to fetch the lyrics from Deezer.
  /// You can disable this behavior by setting [shouldSkipTrackSource] to true.
  Future<Lyrics?> getCurrentPlayingTrackLyrics(String guildId, {bool shouldSkipTrackSource = false}) async {
    final response = await client.executeSafe(
      'GET',
      '/v4/sessions/${client.connection.sessionId}/players/$guildId/track/lyrics',
      queryParameters: {'skipTrackSource': shouldSkipTrackSource.toString()},
    );

    // 204: No Content
    if (response.isEmpty) {
      return null;
    }

    return Lyrics.fromJson(jsonDecode(response));
  }

  /// Subscribes to live lyrics for a given player.
  Future<void> subscribeToLiveLyrics(String guildId, {bool shouldSkipTrackSource = false}) async {
    await client.executeSafe(
      'POST',
      '/v4/sessions/${client.connection.sessionId}/players/$guildId/lyrics/subscribe',
      queryParameters: {'skipTrackSource': shouldSkipTrackSource.toString()},
    );
  }

  /// Unsubscribes from live lyrics for a given player.
  Future<void> unsubscribeFromLiveLyrics(String guildId) async {
    await client.executeSafe('DELETE', '/v4/sessions/${client.connection.sessionId}/players/$guildId/lyrics/subscribe');
  }
}

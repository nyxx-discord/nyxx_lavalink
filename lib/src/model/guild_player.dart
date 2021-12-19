import 'package:nyxx/nyxx.dart';

import 'package:nyxx_lavalink/src/model/track.dart';
import 'package:nyxx_lavalink/src/node/node.dart';

abstract class IGuildPlayer {
  /// Track queue
  List<IQueuedTrack> get queue;

  /// The currently playing track
  IQueuedTrack? get nowPlaying;

  /// Guild where this player operates on
  Snowflake get guildId;
}

/// A player of a specific guild
class GuildPlayer implements IGuildPlayer {
  /// Track queue
  @override
  List<QueuedTrack> queue = [];

  /// The currently playing track
  @override
  QueuedTrack? nowPlaying;

  /// Guild where this player operates on
  @override
  final Snowflake guildId;

  /// A map to combine server state and server update events to send them to lavalink
  final Map<String, dynamic> _serverUpdate = {};

  /// A reference to the parent node
  final INode _nodeRef;

  GuildPlayer(this._nodeRef, this.guildId);

  void _dispatchVoiceUpdate() {
    if (_serverUpdate.containsKey("sessionId") && _serverUpdate.containsKey("event")) {
      (_nodeRef as Node).sendPayload("voiceUpdate", guildId, _serverUpdate);
    }
  }

  void handleServerUpdate(IVoiceServerUpdateEvent event) {
    _serverUpdate["event"] = {"token": event.token, "endpoint": event.endpoint, "guildId": guildId.toString()};

    _dispatchVoiceUpdate();
  }

  void handleStateUpdate(IVoiceStateUpdateEvent event) {
    _serverUpdate["sessionId"] = event.state.sessionId;

    _dispatchVoiceUpdate();
  }
}

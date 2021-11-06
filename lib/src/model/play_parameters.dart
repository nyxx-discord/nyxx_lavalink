import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/src/model/track.dart';
import 'package:nyxx_lavalink/src/node/node.dart';

abstract class IPlayParameters {
  /// The track to play
  ITrack get track;

  /// The guild where the track will be played
  Snowflake get guildId;

  /// Whether to replace the track or not
  bool get replace;

  /// The time at where the track will start to play
  Duration get startTime;

  /// The time at where the track will stop playing
  Duration? get endTime;

  /// The requester of the track
  Snowflake? get requester;

  /// The channel where this track was requested
  Snowflake? get channelId;

  /// Forces the song to start playing
  void startPlaying();

  /// Puts the track on the queue and starts playing if necessary
  void queue();
}

/// Parameters to start playing a track
class PlayParameters implements IPlayParameters {
  final INode _node;

  /// The track to play
  @override
  final ITrack track;

  /// The guild where the track will be played
  @override
  final Snowflake guildId;

  /// Whether to replace the track or not
  @override
  bool replace;

  /// The time at where the track will start to play
  @override
  Duration startTime;

  /// The time at where the track will stop playing
  @override
  Duration? endTime;

  /// The requester of the track
  @override
  Snowflake? requester;

  /// The channel where this track was requested
  @override
  Snowflake? channelId;

  /// Create a new play parameters object, it is recommended to create this
  /// through [Node.play]
  PlayParameters(this._node, this.track, this.guildId, this.replace, this.startTime, this.endTime, this.requester, this.channelId);

  /// Forces the song to start playing
  void startPlaying() {
    if (endTime == null) {
      (_node as Node).sendPayload("play", guildId, {"track": track.track, "noReplace": !replace, "startTime": startTime.inMilliseconds});

      return;
    }

    (_node as Node).sendPayload("play", guildId, {"track": track.track, "noReplace": !replace, "startTime": startTime, "endTime": endTime!.inMilliseconds});
  }

  /// Puts the track on the queue and starts playing if necessary
  void queue() {
    final player = (_node as Node).players[guildId];

    if (player == null) {
      return;
    }

    final queuedTrack = QueuedTrack(track, startTime, endTime, requester, channelId);

    // Whether if the node should start playing the track
    final shouldPlay = player.nowPlaying == null && player.queue.isEmpty;
    player.queue.add(queuedTrack);

    if (shouldPlay) {
      (_node as Node).playNext(guildId);
    }
  }
}

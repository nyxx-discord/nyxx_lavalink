import 'package:nyxx/nyxx.dart';

import 'package:nyxx_lavalink/src/model/base_event.dart';
import 'package:nyxx_lavalink/src/node/node.dart';

abstract class ITrackStuckEvent implements IBaseEvent {
  /// Base64 encoded track
  String get track;

  /// The wait threshold that was exceeded for this event to trigger
  int get thresholdMs;

  /// Guild where the track got stuck
  Snowflake get guildId;
}

/// Object sent when a track gets stuck when playing
class TrackStuckEvent extends BaseEvent implements ITrackStuckEvent {
  /// Base64 encoded track
  @override
  late final String track;

  /// The wait threshold that was exceeded for this event to trigger
  @override
  late final int thresholdMs;

  /// Guild where the track got stuck
  @override
  late final Snowflake guildId;

  TrackStuckEvent(INyxxRest client, INode node, Map<String, dynamic> json) : super(client, node) {
    track = json["track"] as String;
    thresholdMs = json["thresholdMs"] as int;
    guildId = Snowflake(json["guildId"] as String);
  }
}

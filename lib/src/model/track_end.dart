import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/src/model/base_event.dart';
import 'package:nyxx_lavalink/src/node/node.dart';

abstract class ITrackEndEvent implements IBaseEvent {
  /// Reason to the track to end
  String get reason;

  /// Base64 encoded track
  String get track;

  /// Guild where the track ended
  Snowflake get guildId;
}

/// Object sent when a track ends playing
class TrackEndEvent extends BaseEvent implements ITrackEndEvent {
  /// Reason to the track to end
  @override
  late final String reason;

  /// Base64 encoded track
  @override
  late final String track;

  /// Guild where the track ended
  @override
  late final Snowflake guildId;

  TrackEndEvent(INyxxRest client, INode node, Map<String, dynamic> json) : super(client, node) {
    reason = json["reason"] as String;
    track = json["track"] as String;
    guildId = Snowflake(json["guildId"] as String);
  }
}

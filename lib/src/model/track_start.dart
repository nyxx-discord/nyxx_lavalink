import 'package:nyxx/nyxx.dart';

import 'package:nyxx_lavalink/src/model/base_event.dart';
import 'package:nyxx_lavalink/src/node/node.dart';

abstract class ITrackStartEvent implements IBaseEvent {
  /// Track start type (if its replaced or not the track)
  String get startType;

  /// Base64 encoded track
  String get track;

  /// Guild where the track started
  Snowflake get guildId;
}

/// Object sent when a track starts playing
class TrackStartEvent extends BaseEvent implements ITrackStartEvent {
  /// Track start type (if its replaced or not the track)
  @override
  late final String startType;

  /// Base64 encoded track
  @override
  late final String track;

  /// Guild where the track started
  @override
  late final Snowflake guildId;

  TrackStartEvent(INyxx client, INode node, Map<String, dynamic> json) : super(client, node) {
    startType = json["type"] as String;
    track = json["track"] as String;
    guildId = Snowflake(json["guildId"]);
  }
}

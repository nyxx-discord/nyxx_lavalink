import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/src/model/base_event.dart';
import 'package:nyxx_lavalink/src/model/exception.dart';
import 'package:nyxx_lavalink/src/node/node.dart';

abstract class ITrackExceptionEvent implements IBaseEvent {
  /// Base64 encoded track
  String get track;

  /// The occurred error
  ILavalinkException get exception;

  /// Guild id where the track got an exception
  Snowflake get guildId;
}

/// Object sent when a track gets an exception while playing
class TrackExceptionEvent extends BaseEvent implements ITrackExceptionEvent {
  /// Base64 encoded track
  @override
  late final String track;

  /// The occurred error
  @override
  late final ILavalinkException exception;

  /// Guild id where the track got an exception
  @override
  late final Snowflake guildId;

  TrackExceptionEvent(INyxx client, INode node, Map<String, dynamic> json) : super(client, node) {
    track = json["track"] as String;
    exception = LavalinkException(json);
    guildId = Snowflake(json["guildId"]);
  }
}

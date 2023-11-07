import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/track.dart';

part 'track_end.g.dart';

@JsonSerializable()
class TrackEndEvent extends LavalinkEvent {
  final Track track;
  final String reason;

  TrackEndEvent({
    required super.client,
    required super.opType,
    required super.type,
    required super.guildId,
    required this.track,
    required this.reason,
  });

  factory TrackEndEvent.fromJson(Map<String, Object?> json) => _$TrackEndEventFromJson(json);
}

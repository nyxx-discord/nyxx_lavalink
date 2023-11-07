import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/track.dart';

part 'track_stuck.g.dart';

@JsonSerializable()
class TrackStuckEvent extends LavalinkEvent {
  final Track track;
  final Duration threshold;

  TrackStuckEvent({
    required super.client,
    required super.opType,
    required super.type,
    required super.guildId,
    required this.track,
    required this.threshold,
  });

  factory TrackStuckEvent.fromJson(Map<String, Object?> json) => _$TrackStuckEventFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/track.dart';

part 'track_start.g.dart';

@JsonSerializable()
class TrackStartEvent extends LavalinkEvent {
  final Track track;

  TrackStartEvent({
    required super.client,
    required super.opType,
    required super.type,
    required super.guildId,
    required this.track,
  });

  factory TrackStartEvent.fromJson(Map<String, Object?> json) => _$TrackStartEventFromJson(json);
}

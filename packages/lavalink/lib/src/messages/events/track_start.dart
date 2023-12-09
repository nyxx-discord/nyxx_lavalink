import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/track.dart';

part 'track_start.g.dart';

/// An event sent when a track starts playing.
@JsonSerializable()
class TrackStartEvent extends LavalinkEvent {
  /// The track that started playing.
  final Track track;

  /// Create a new [TrackStartEvent].
  TrackStartEvent({
    required super.client,
    required super.opType,
    required super.type,
    required super.guildId,
    required this.track,
  });

  factory TrackStartEvent.fromJson(Map<String, Object?> json) => _$TrackStartEventFromJson(json);
}

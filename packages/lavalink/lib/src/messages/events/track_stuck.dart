import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/track.dart';

part 'track_stuck.g.dart';

/// An event sent when a [Track] gets stuck while playing.
@JsonSerializable()
class TrackStuckEvent extends LavalinkEvent {
  /// The track that got stuck.
  final Track track;

  /// The threshold that was exceeded.
  final Duration threshold;

  /// Create a new [TrackStuckEvent].
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

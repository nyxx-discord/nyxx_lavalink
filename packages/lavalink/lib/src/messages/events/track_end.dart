import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/track.dart';

part 'track_end.g.dart';

/// An event sent when the end of a [Track] is reached.
@JsonSerializable()
class TrackEndEvent extends LavalinkEvent {
  /// The track that ended.
  final Track track;

  /// The reason why the track ended.
  final String reason;

  /// Create a new [TrackEndEvent].
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

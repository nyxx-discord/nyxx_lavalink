import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/lavalink.dart';
import 'package:lavalink_plugins/src/sponsorblock/models/segment.dart';

part 'segments_loaded.g.dart';

/// Fired when the segments for a track are loaded.
@JsonSerializable()
class SegmentsLoaded extends LavalinkEvent {
  /// All the segments of this track.
  final List<Segment> segments;

  SegmentsLoaded({
    required super.client,
    required super.opType,
    required super.guildId,
    required super.type,
    required this.segments,
  });

  factory SegmentsLoaded.fromJson(Map<String, Object?> json) => _$SegmentsLoadedFromJson(json);
}

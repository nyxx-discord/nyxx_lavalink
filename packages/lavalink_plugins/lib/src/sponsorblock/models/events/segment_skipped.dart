import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/lavalink.dart';
import 'package:lavalink_plugins/src/sponsorblock/models/segment.dart';

part 'segment_skipped.g.dart';

/// An event that happens when a segment has been skipped.
@JsonSerializable()
class SegmentSkipped extends LavalinkEvent {
  /// The segment that has been skipped.
  final Segment segment;

  SegmentSkipped({required super.client, required super.guildId, required super.opType, required super.type, required this.segment});

  factory SegmentSkipped.fromJson(Map<String, Object?> json) => _$SegmentSkippedFromJson(json);
}

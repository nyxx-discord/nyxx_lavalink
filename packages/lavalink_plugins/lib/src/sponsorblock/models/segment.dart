import 'package:json_annotation/json_annotation.dart';
// ignore: implementation_imports
import 'package:lavalink/src/utils/deserializing_utils.dart';
import 'package:lavalink_plugins/src/sponsorblock/models/segment_category.dart';

part 'segment.g.dart';

/// A segment of the timespan of the sponsorblock data.
@JsonSerializable()
class Segment {
  /// The category of this segment.
  final SegmentCategory category;

  /// The start of this segment. (i.e `0`)
  @JsonKey(fromJson: durationFromMilliseconds)
  final Duration start;

  /// The end of this segment. (i.e `12`)
  @JsonKey(fromJson: durationFromMilliseconds)
  final Duration end;

  const Segment({required this.category, required this.start, required this.end});

  factory Segment.fromJson(Map<String, Object?> json) => _$SegmentFromJson(json);
}

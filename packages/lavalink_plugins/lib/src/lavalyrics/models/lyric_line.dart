import 'package:json_annotation/json_annotation.dart';

// ignore: implementation_imports
import 'package:lavalink/src/utils/deserializing_utils.dart';

part 'lyric_line.g.dart';

@JsonSerializable()
class LyricLine {
  /// The timespan of the line.
  @JsonKey(fromJson: durationFromMilliseconds)
  final Duration timestamp;

  /// The duration of the line.
  @JsonKey(fromJson: durationFromMilliseconds)
  final Duration? duration;

  /// The lyric line.
  final String line;

  /// Additional plugin specific data.
  final Map<String, Object?> plugin;

  const LyricLine({required this.duration, required this.line, required this.plugin, required this.timestamp});

  factory LyricLine.fromJson(Map<String, Object?> json) => _$LyricLineFromJson(json);
}

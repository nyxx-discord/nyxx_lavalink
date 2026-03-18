import 'package:json_annotation/json_annotation.dart';
// ignore: implementation_imports
import 'package:lavalink/src/utils/deserializing_utils.dart';

part 'chapter.g.dart';

Duration _durationFromStringMilliseconds(String ms) => durationFromMilliseconds(int.parse(ms));

@JsonSerializable()
class Chapter {
  /// The name of this chapter.
  final String name;

  /// The start span of this chapter.
  @JsonKey(fromJson: durationFromMilliseconds)
  final Duration start;

  /// The end span of this chapter.
  @JsonKey(fromJson: durationFromMilliseconds)
  final Duration end;

  /// The whole duration of the span.
  @JsonKey(fromJson: _durationFromStringMilliseconds)
  final Duration duration;

  const Chapter({required this.duration, required this.end, required this.name, required this.start});

  factory Chapter.fromJson(Map<String, Object?> json) => _$ChapterFromJson(json);
}

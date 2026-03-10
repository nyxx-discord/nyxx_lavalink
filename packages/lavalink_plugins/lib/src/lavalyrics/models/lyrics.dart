import 'package:json_annotation/json_annotation.dart';

import 'lyric_line.dart';

part 'lyrics.g.dart';

@JsonSerializable()
class Lyrics {
  /// The name of the source where the lyrics were fetched from.
  final String sourceName;

  /// The name of the provider the lyrics was fetched from on the source.
  final String provider;

  /// The lyrics text.
  final String? text;

  /// The lyrics lines.
  final List<LyricLine> lines;

  /// Additional plugin specific data.
  final Map<String, Object?> plugin;

  const Lyrics({required this.sourceName, required this.provider, required this.text, required this.lines, required this.plugin});

  factory Lyrics.fromJson(Map<String, Object?> json) => _$LyricsFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_line_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LyricsLineEvent _$LyricsLineEventFromJson(Map<String, dynamic> json) => LyricsLineEvent(
  client: identity(json['client'] as LavalinkClient),
  opType: json['op'] as String,
  type: json['type'] as String,
  guildId: json['guildId'] as String,
  hasBeenSkipped: json['skipped'] as bool,
  line: (json['line'] as List<dynamic>).map((e) => LyricLine.fromJson(e as Map<String, dynamic>)).toList(),
  lineIndex: (json['lineIndex'] as num).toInt(),
);

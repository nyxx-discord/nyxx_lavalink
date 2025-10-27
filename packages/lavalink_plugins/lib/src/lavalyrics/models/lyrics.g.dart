// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lyrics _$LyricsFromJson(Map<String, dynamic> json) => Lyrics(
      sourceName: json['sourceName'] as String,
      provider: json['provider'] as String,
      text: json['text'] as String?,
      lines: (json['lines'] as List<dynamic>)
          .map((e) => LyricLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      plugin: json['plugin'] as Map<String, dynamic>,
    );

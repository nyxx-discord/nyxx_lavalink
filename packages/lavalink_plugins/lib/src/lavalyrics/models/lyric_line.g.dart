// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyric_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LyricLine _$LyricLineFromJson(Map<String, dynamic> json) => LyricLine(
      duration: durationFromMilliseconds((json['duration'] as num).toInt()),
      line: json['line'] as String,
      plugin: json['plugin'] as Map<String, dynamic>,
      timestamp: durationFromMilliseconds((json['timestamp'] as num).toInt()),
    );

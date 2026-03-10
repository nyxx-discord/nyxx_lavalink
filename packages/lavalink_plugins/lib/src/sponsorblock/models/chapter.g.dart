// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      duration: _durationFromStringMilliseconds(json['duration'] as String),
      end: durationFromMilliseconds((json['end'] as num).toInt()),
      name: json['name'] as String,
      start: durationFromMilliseconds((json['start'] as num).toInt()),
    );

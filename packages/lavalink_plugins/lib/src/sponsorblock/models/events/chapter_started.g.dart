// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_started.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterStarted _$ChapterStartedFromJson(Map<String, dynamic> json) => ChapterStarted(
      client: identity(json['client'] as LavalinkClient),
      guildId: json['guildId'] as String,
      opType: json['op'] as String,
      type: json['type'] as String,
      chapter: Chapter.fromJson(json['chapter'] as Map<String, dynamic>),
    );

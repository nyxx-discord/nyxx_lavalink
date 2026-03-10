// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapters_loaded.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChaptersLoaded _$ChaptersLoadedFromJson(Map<String, dynamic> json) => ChaptersLoaded(
  client: identity(json['client'] as LavalinkClient),
  guildId: json['guildId'] as String,
  opType: json['op'] as String,
  type: json['type'] as String,
  chapters: (json['chapters'] as List<dynamic>).map((e) => Chapter.fromJson(e as Map<String, dynamic>)).toList(),
);

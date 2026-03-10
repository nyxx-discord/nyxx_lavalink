// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segments_loaded.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SegmentsLoaded _$SegmentsLoadedFromJson(Map<String, dynamic> json) => SegmentsLoaded(
      client: identity(json['client'] as LavalinkClient),
      opType: json['op'] as String,
      guildId: json['guildId'] as String,
      type: json['type'] as String,
      segments: (json['segments'] as List<dynamic>).map((e) => Segment.fromJson(e as Map<String, dynamic>)).toList(),
    );

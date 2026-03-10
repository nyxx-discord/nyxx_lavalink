// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segment_skipped.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SegmentSkipped _$SegmentSkippedFromJson(Map<String, dynamic> json) => SegmentSkipped(
      client: identity(json['client'] as LavalinkClient),
      guildId: json['guildId'] as String,
      opType: json['op'] as String,
      type: json['type'] as String,
      segment: Segment.fromJson(json['segment'] as Map<String, dynamic>),
    );

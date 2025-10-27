// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Segment _$SegmentFromJson(Map<String, dynamic> json) => Segment(
      category: $enumDecode(_$SegmentCategoryEnumMap, json['category']),
      start: durationFromMilliseconds((json['start'] as num).toInt()),
      end: durationFromMilliseconds((json['end'] as num).toInt()),
    );

const _$SegmentCategoryEnumMap = {
  SegmentCategory.sponsor: 'sponsor',
  SegmentCategory.selfPromo: 'selfpromo',
  SegmentCategory.interaction: 'interaction',
  SegmentCategory.intro: 'intro',
  SegmentCategory.outro: 'outro',
  SegmentCategory.preview: 'preview',
  SegmentCategory.musicOfftopic: 'music_offtopic',
  SegmentCategory.filler: 'filler',
};

import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'category')
enum SegmentCategory {
  sponsor('sponsor'),
  selfPromo('selfpromo'),
  interaction('interaction'),
  intro('intro'),
  outro('outro'),
  preview('preview'),
  musicOfftopic('music_offtopic'),
  filler('filler');

  final String category;
  const SegmentCategory(this.category);
}

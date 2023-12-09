// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatsMessage _$StatsMessageFromJson(Map<String, dynamic> json) => StatsMessage(
      client: identity(json['client'] as LavalinkClient),
      opType: json['op'] as String,
      stats: LavalinkStats.fromJson(_readFromSelf(json, 'stats') as Map<String, dynamic>),
    );

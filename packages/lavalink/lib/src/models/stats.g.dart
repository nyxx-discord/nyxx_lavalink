// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LavalinkStats _$LavalinkStatsFromJson(Map<String, dynamic> json) => LavalinkStats(
      players: (json['players'] as num).toInt(),
      playingPlayers: (json['playingPlayers'] as num).toInt(),
      uptime: Duration(microseconds: (json['uptime'] as num).toInt()),
      memory: MemoryStats.fromJson(json['memory'] as Map<String, dynamic>),
      cpu: CpuStats.fromJson(json['cpu'] as Map<String, dynamic>),
      frames: json['frames'] == null ? null : FrameStats.fromJson(json['frames'] as Map<String, dynamic>),
    );

MemoryStats _$MemoryStatsFromJson(Map<String, dynamic> json) => MemoryStats(
      free: (json['free'] as num).toInt(),
      used: (json['used'] as num).toInt(),
      allocated: (json['allocated'] as num).toInt(),
      reservable: (json['reservable'] as num).toInt(),
    );

CpuStats _$CpuStatsFromJson(Map<String, dynamic> json) => CpuStats(
      cores: (json['cores'] as num).toInt(),
      systemLoad: (json['systemLoad'] as num).toDouble(),
      lavalinkLoad: (json['lavalinkLoad'] as num).toDouble(),
    );

FrameStats _$FrameStatsFromJson(Map<String, dynamic> json) => FrameStats(
      sent: (json['sent'] as num).toInt(),
      nulled: (json['nulled'] as num).toInt(),
      deficit: (json['deficit'] as num).toInt(),
    );

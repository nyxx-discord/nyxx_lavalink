// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LavalinkStats _$LavalinkStatsFromJson(Map<String, dynamic> json) =>
    LavalinkStats(
      players: json['players'] as int,
      playingPlayers: json['playingPlayers'] as int,
      uptime: Duration(microseconds: json['uptime'] as int),
      memory: MemoryStats.fromJson(json['memory'] as Map<String, dynamic>),
      cpu: CpuStats.fromJson(json['cpu'] as Map<String, dynamic>),
      frames: json['frames'] == null
          ? null
          : FrameStats.fromJson(json['frames'] as Map<String, dynamic>),
    );

MemoryStats _$MemoryStatsFromJson(Map<String, dynamic> json) => MemoryStats(
      free: json['free'] as int,
      used: json['used'] as int,
      allocated: json['allocated'] as int,
      reservable: json['reservable'] as int,
    );

CpuStats _$CpuStatsFromJson(Map<String, dynamic> json) => CpuStats(
      cores: json['cores'] as int,
      systemLoad: (json['systemLoad'] as num).toDouble(),
      lavalinkLoad: (json['lavalinkLoad'] as num).toDouble(),
    );

FrameStats _$FrameStatsFromJson(Map<String, dynamic> json) => FrameStats(
      sent: json['sent'] as int,
      nulled: json['nulled'] as int,
      deficit: json['deficit'] as int,
    );

import 'package:json_annotation/json_annotation.dart';

part 'stats.g.dart';

@JsonSerializable()
class LavalinkStats {
  final int players;
  final int playingPlayers;
  final Duration uptime;
  final MemoryStats memory;
  final CpuStats cpu;
  final FrameStats? frames;

  LavalinkStats({
    required this.players,
    required this.playingPlayers,
    required this.uptime,
    required this.memory,
    required this.cpu,
    required this.frames,
  });

  factory LavalinkStats.fromJson(Map<String, Object?> json) => _$LavalinkStatsFromJson(json);
}

@JsonSerializable()
class MemoryStats {
  final int free;
  final int used;
  final int allocated;
  final int reservable;

  MemoryStats({
    required this.free,
    required this.used,
    required this.allocated,
    required this.reservable,
  });

  factory MemoryStats.fromJson(Map<String, Object?> json) => _$MemoryStatsFromJson(json);
}

@JsonSerializable()
class CpuStats {
  final int cores;
  final double systemLoad;
  final double lavalinkLoad;

  CpuStats({required this.cores, required this.systemLoad, required this.lavalinkLoad});

  factory CpuStats.fromJson(Map<String, Object?> json) => _$CpuStatsFromJson(json);
}

@JsonSerializable()
class FrameStats {
  final int sent;
  final int nulled;
  final int deficit;

  FrameStats({required this.sent, required this.nulled, required this.deficit});

  factory FrameStats.fromJson(Map<String, Object?> json) => _$FrameStatsFromJson(json);
}

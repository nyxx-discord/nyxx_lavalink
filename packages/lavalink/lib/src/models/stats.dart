import 'package:json_annotation/json_annotation.dart';

part 'stats.g.dart';

/// A collection of statistics about a Lavalink server.
@JsonSerializable()
class LavalinkStats {
  /// The current number of players.
  final int players;

  /// The current number of players playing audio.
  final int playingPlayers;

  /// The server's uptime.
  final Duration uptime;

  /// Statistics about the server's memory usage.
  final MemoryStats memory;

  /// Statistics about the server's CPU usage.
  final CpuStats cpu;

  /// Statistics about audio frames sent by the server.
  final FrameStats? frames;

  /// Create a new [LavalinkStats].
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

/// Statistics about a Lavalink server's memory usage.
@JsonSerializable()
class MemoryStats {
  /// The free memory in bytes.
  final int free;

  /// The used memory in bytes.
  final int used;

  /// The allocated memory in bytes.
  final int allocated;

  /// The reservable memory in bytes.
  final int reservable;

  /// Create a new [MemoryStats].
  MemoryStats({
    required this.free,
    required this.used,
    required this.allocated,
    required this.reservable,
  });

  factory MemoryStats.fromJson(Map<String, Object?> json) => _$MemoryStatsFromJson(json);
}

/// Statistics about a Lavalink server's CPU usage.
@JsonSerializable()
class CpuStats {
  /// The number of cores on the system the server is running on.
  final int cores;

  /// The current system load.
  final double systemLoad;

  /// The current Lavalink load.
  final double lavalinkLoad;

  /// Create a new [CpuStats].
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

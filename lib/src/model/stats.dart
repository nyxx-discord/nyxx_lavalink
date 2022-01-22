import 'package:nyxx/nyxx.dart';

import 'package:nyxx_lavalink/src/model/base_event.dart';
import 'package:nyxx_lavalink/src/node/node.dart';

abstract class IStatsEvent implements IBaseEvent {
  /// Number of playing players
  int get playingPlayers;

  ///Memory usage stats
  IMemoryStats get memory;

  /// Frame sending stats
  IFrameStats? get frameStats;

  /// Total amount of players
  int get players;

  /// Cpu usage stats
  ICpuStats get cpu;

  /// Server uptime
  int get uptime;
}

/// Stats update event dispatched by lavalink
class StatsEvent extends BaseEvent implements IStatsEvent {
  /// Number of playing players
  @override
  late final int playingPlayers;

  ///Memory usage stats
  @override
  late final IMemoryStats memory;

  /// Frame sending stats
  @override
  late final IFrameStats? frameStats;

  /// Total amount of players
  @override
  late final int players;

  /// Cpu usage stats
  @override
  late final ICpuStats cpu;

  /// Server uptime
  @override
  late final int uptime;

  StatsEvent(INyxxRest client, INode node, Map<String, dynamic> json) : super(client, node) {
    playingPlayers = json["playingPlayers"] as int;
    players = json["players"] as int;
    uptime = json["uptime"] as int;
    memory = MemoryStats(json["memory"] as Map<String, dynamic>);
    frameStats = json["frameStats"] == null ? null : FrameStats(json["frameStats"] as Map<String, dynamic>);
    cpu = CpuStats(json["cpu"] as Map<String, dynamic>);
  }
}

abstract class IFrameStats {
  /// Sent frames
  int get sent;

  /// Deficit frames
  int get deficit;

  /// Nulled frames
  int get nulled;
}

/// Stats about frame sending to discord
class FrameStats implements IFrameStats {
  /// Sent frames
  @override
  late final int sent;

  /// Deficit frames
  @override
  late final int deficit;

  /// Nulled frames
  @override
  late final int nulled;

  FrameStats(Map<String, dynamic> json) {
    sent = json["sent"] as int;
    deficit = json["deficit"] as int;
    nulled = json["nulled"] as int;
  }
}

abstract class ICpuStats {
  /// Amount of available cores on the cpu
  int get cores;

  /// The total load of the machine where lavalink is running on
  num get systemLoad;

  /// The total load of lavalink server
  num get lavalinkLoad;
}

/// Cpu usage stats
class CpuStats implements ICpuStats {
  /// Amount of available cores on the cpu
  @override
  late final int cores;

  /// The total load of the machine where lavalink is running on
  @override
  late final num systemLoad;

  /// The total load of lavalink server
  @override
  late final num lavalinkLoad;

  CpuStats(Map<String, dynamic> json) {
    cores = json["cores"] as int;
    systemLoad = json["systemLoad"] as num;
    lavalinkLoad = json["lavalinkLoad"] as num;
  }
}

abstract class IMemoryStats {
  /// Reservable memory
  int get reservable;

  /// Used memory
  int get used;

  /// Free/unused memory
  int get free;

  /// Total allocated memory
  int get allocated;
}

/// Memory usage stats
class MemoryStats implements IMemoryStats {
  /// Reservable memory
  @override
  late final int reservable;

  /// Used memory
  @override
  late final int used;

  /// Free/unused memory
  @override
  late final int free;

  /// Total allocated memory
  @override
  late final int allocated;

  MemoryStats(Map<String, dynamic> json) {
    reservable = json["reservable"] as int;
    used = json["used"] as int;
    free = json["free"] as int;
    allocated = json["allocated"] as int;
  }
}

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/src/model/base_event.dart';
import 'package:nyxx_lavalink/src/node/node.dart';

abstract class IPlayerUpdateEvent implements IBaseEvent {
  /// State of the current player
  IPlayerUpdateStateEvent get state;

  /// Guild id where player comes from
  Snowflake get guildId;
}

/// Player update event dispatched by lavalink at player progression
class PlayerUpdateEvent extends BaseEvent implements IPlayerUpdateEvent {
  /// State of the current player
  @override
  late final IPlayerUpdateStateEvent state;

  /// Guild id where player comes from
  @override
  late final Snowflake guildId;

  PlayerUpdateEvent(INyxx client, INode node, Map<String, dynamic> json) : super(client, node) {
    guildId = Snowflake(json["guildId"]);
    state = PlayerUpdateStateEvent(json["state"]["time"] as int, json["state"]["position"] as int?);
  }
}

abstract class IPlayerUpdateStateEvent {
  /// The timestamp of the player
  int get time;

  /// The position where the current track is now on
  int? get position;
}

/// The state of a player at a given moment
class PlayerUpdateStateEvent implements IPlayerUpdateStateEvent {
  /// The timestamp of the player
  @override
  final int time;

  /// The position where the current track is now on
  @override
  final int? position;

  PlayerUpdateStateEvent(this.time, this.position);
}

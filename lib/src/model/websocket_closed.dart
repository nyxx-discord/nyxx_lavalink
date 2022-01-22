import 'package:nyxx/nyxx.dart';

import 'package:nyxx_lavalink/src/model/base_event.dart';
import 'package:nyxx_lavalink/src/node/node.dart';

abstract class IWebSocketClosedEvent implements IBaseEvent {
  /// Guild where the websocket has closed
  Snowflake get guildId;

  /// Close code
  int get code;

  /// Reason why the socket closed
  String get reason;

  /// If the connection was closed by discord
  bool get byRemote;
}

/// Web socket closed event from lavalink
class WebSocketClosedEvent extends BaseEvent implements IWebSocketClosedEvent {
  /// Guild where the websocket has closed
  @override
  late final Snowflake guildId;

  /// Close code
  @override
  late final int code;

  /// Reason why the socket closed
  @override
  late final String reason;

  /// If the connection was closed by discord
  @override
  late final bool byRemote;

  WebSocketClosedEvent(INyxxRest client, INode node, Map<String, dynamic> json) : super(client, node) {
    guildId = Snowflake(json["guildId"]);
    code = json["code"] as int;
    reason = json["reason"] as String;
    byRemote = json["byRemote"] as bool;
  }
}

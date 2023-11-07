import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';
import 'package:lavalink/src/messages/message.dart';

part 'websocket_closed.g.dart';

@JsonSerializable()
class WebSocketClosedEvent extends LavalinkEvent {
  final int code;
  final String reason;
  final bool wasByRemote;

  WebSocketClosedEvent({
    required super.client,
    required super.opType,
    required super.type,
    required super.guildId,
    required this.code,
    required this.reason,
    required this.wasByRemote,
  });

  factory WebSocketClosedEvent.fromJson(Map<String, Object?> json) =>
      _$WebSocketClosedEventFromJson(json);
}

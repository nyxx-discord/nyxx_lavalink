import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';
import 'package:lavalink/src/messages/message.dart';

part 'websocket_closed.g.dart';

/// An event sent when the websocket connection to Discord's voice servers is lost.
@JsonSerializable()
class WebSocketClosedEvent extends LavalinkEvent {
  /// The close code of the websocket connection.
  final int code;

  /// The reason the connection was closed.
  final String reason;

  /// Whether the connection was closed by the remote server (Discord).
  final bool? wasByRemote;

  /// Create a new [WebSocketClosedEvent].
  WebSocketClosedEvent({
    required super.client,
    required super.opType,
    required super.type,
    required super.guildId,
    required this.code,
    required this.reason,
    required this.wasByRemote,
  });

  factory WebSocketClosedEvent.fromJson(Map<String, Object?> json) => _$WebSocketClosedEventFromJson(json);
}

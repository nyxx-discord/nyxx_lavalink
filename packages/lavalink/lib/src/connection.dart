import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/events/track_end.dart';
import 'package:lavalink/src/messages/events/track_exception.dart';
import 'package:lavalink/src/messages/events/track_start.dart';
import 'package:lavalink/src/messages/events/track_stuck.dart';
import 'package:lavalink/src/messages/events/websocket_closed.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/messages/player_update.dart';
import 'package:lavalink/src/messages/ready.dart';
import 'package:lavalink/src/messages/stats.dart';

/// A websocket connection to a Lavalink server.
///
/// Provides a stream interface that exposes messages sent by the server and errors encountered by
/// the connection.
class LavalinkConnection extends Stream<LavalinkMessage> {
  /// The client this connection is for.
  final LavalinkClient client;

  /// The ID of the current session this connection is using.
  // Only safe to read after the first ready event, but instances of this class are not returned
  // from LavalinkConnection.connect until that happens.
  String get sessionId => _sessionId!;
  // Use internally; will only be null before the first ready event.
  String? _sessionId;

  final StreamController<LavalinkMessage> _messagesController = StreamController();
  final Completer<void> _readyCompleter = Completer();
  WebSocket? _webSocket;
  bool _closing = false;

  LavalinkConnection._({required this.client}) {
    _run();
  }

  /// Create a new connection to a Lavalink server and wait for it to be ready.
  static Future<LavalinkConnection> connect(LavalinkClient client) async {
    final connection = LavalinkConnection._(client: client);
    await connection._readyCompleter.future;
    return connection;
  }

  @override
  StreamSubscription<LavalinkMessage> listen(
    void Function(LavalinkMessage event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _messagesController.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  Future<void> _run() async {
    while (!_closing) {
      try {
        _webSocket = await WebSocket.connect(
          client.base
              .resolve('v4/websocket')
              .replace(scheme: client.base.isScheme('https') ? 'wss' : 'ws')
              .toString(),
          headers: {
            'Authorization': client.password,
            'User-Id': client.userId,
            'Client-Name': client.clientName,
            if (_sessionId != null) 'Session-Id': _sessionId!,
          },
        );

        await for (final message in _webSocket!) {
          assert(message is String);
          final json = <String, Object?>{
            ...jsonDecode(message),
            // All the fromJson constructors read the client from the map.
            'client': client,
          };

          final parsedMessage = switch (json['op']) {
            'ready' => LavalinkReadyMessage.fromJson(json),
            'playerUpdate' => PlayerUpdateMessage.fromJson(json),
            'stats' => StatsMessage.fromJson(json),
            'event' => switch (json['type']) {
                'TrackStartEvent' => TrackStartEvent.fromJson(json),
                'TrackEndEvent' => TrackEndEvent.fromJson(json),
                'TrackExceptionEvent' => TrackExceptionEvent.fromJson(json),
                'TrackStuckEvent' => TrackStuckEvent.fromJson(json),
                'WebSocketClosedEvent' => WebSocketClosedEvent.fromJson(json),
                final unknownEvent => throw FormatException('Unknown event type: $unknownEvent'),
              },
            final unknownMessage => throw FormatException('Unknown message type: $unknownMessage')
          };

          _messagesController.add(parsedMessage);
          if (parsedMessage is LavalinkReadyMessage) {
            _sessionId = parsedMessage.sessionId;
            if (!_readyCompleter.isCompleted) {
              _readyCompleter.complete(null);
            }
          }
        }
      } catch (error, stack) {
        _messagesController.addError(error, stack);
      }
    }

    await _messagesController.close();
  }

  /// Close this connection and all associated resources.
  Future<void> close() async {
    _closing = true;
    await _webSocket?.close(1000);
    await _messagesController.done;
  }
}

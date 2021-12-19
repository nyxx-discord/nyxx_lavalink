import 'dart:async';

import 'package:nyxx/nyxx.dart';

import 'cluster.dart';
import 'model/stats.dart';
import 'model/track_end.dart';
import 'model/track_start.dart';
import 'model/track_stuck.dart';
import 'model/track_exception.dart';
import 'model/player_update.dart';
import 'model/websocket_closed.dart';
import 'node/node.dart';

abstract class IEventDispatcher implements Disposable {
  /// Emitted when stats are sent from lavalink
  Stream<IStatsEvent> get onStatsReceived;

  /// Emitted when a player gets updated
  Stream<IPlayerUpdateEvent> get onPlayerUpdate;

  /// Emitted when a track starts playing
  Stream<ITrackStartEvent> get onTrackStart;

  /// Emitted when a track ends playing
  Stream<ITrackEndEvent> get onTrackEnd;

  /// Emitted when a track gets an exception during playback
  Stream<ITrackExceptionEvent> get onTrackException;

  /// Emitted when a track gets stuck
  Stream<ITrackStuckEvent> get onTrackStuck;

  /// Emitted when a web socket is closed
  Stream<IWebSocketClosedEvent> get onWebSocketClosed;
}

class EventDispatcher implements IEventDispatcher {
  final Cluster cluster;

  final StreamController<IStatsEvent> onStatsReceivedController = StreamController.broadcast();
  final StreamController<IPlayerUpdateEvent> onPlayerUpdateController = StreamController.broadcast();
  final StreamController<TrackStartEvent> onTrackStartController = StreamController.broadcast();
  final StreamController<TrackEndEvent> onTrackEndController = StreamController.broadcast();
  final StreamController<TrackExceptionEvent> onTrackExceptionController = StreamController.broadcast();
  final StreamController<TrackStuckEvent> onTrackStuckController = StreamController.broadcast();
  final StreamController<WebSocketClosedEvent> onWebSocketClosedController = StreamController.broadcast();

  /// Emitted when stats are sent from lavalink
  @override
  late final Stream<IStatsEvent> onStatsReceived;

  /// Emitted when a player gets updated
  @override
  late final Stream<IPlayerUpdateEvent> onPlayerUpdate;

  /// Emitted when a track starts playing
  @override
  late final Stream<ITrackStartEvent> onTrackStart;

  /// Emitted when a track ends playing
  @override
  late final Stream<ITrackEndEvent> onTrackEnd;

  /// Emitted when a track gets an exception during playback
  @override
  late final Stream<ITrackExceptionEvent> onTrackException;

  /// Emitted when a track gets stuck
  @override
  late final Stream<ITrackStuckEvent> onTrackStuck;

  /// Emitted when a web socket is closed
  @override
  late final Stream<IWebSocketClosedEvent> onWebSocketClosed;

  EventDispatcher(this.cluster) {
    onStatsReceived = onStatsReceivedController.stream;
    onPlayerUpdate = onPlayerUpdateController.stream;
    onTrackStart = onTrackStartController.stream;
    onTrackEnd = onTrackEndController.stream;
    onTrackException = onTrackExceptionController.stream;
    onTrackStuck = onTrackStuckController.stream;
    onWebSocketClosed = onWebSocketClosedController.stream;
  }

  void dispatchEvent(Map<String, dynamic> json) {
    final node = cluster.nodes[json["nodeId"]];

    if (node == null) {
      return;
    }

    cluster.logger.fine("[Node ${json["nodeId"]}] Dispatching ${json["event"]}");

    switch (json["event"]) {
      case "TrackStartEvent":
        onTrackStartController.add(TrackStartEvent(cluster.client, node, json["data"] as Map<String, dynamic>));
        break;

      case "TrackEndEvent":
        {
          final trackEnd = TrackEndEvent(cluster.client, node, json["data"] as Map<String, dynamic>);

          onTrackEndController.add(trackEnd);

          (node as Node).handleTrackEnd(trackEnd);
        }
        break;

      case "TrackExceptionEvent":
        onTrackExceptionController.add(TrackExceptionEvent(cluster.client, node, json["data"] as Map<String, dynamic>));
        break;

      case "TrackStuckEvent":
        onTrackStuckController.add(TrackStuckEvent(cluster.client, node, json["data"] as Map<String, dynamic>));
        break;

      case "WebSocketClosedEvent":
        onWebSocketClosedController.add(WebSocketClosedEvent(cluster.client, node, json["data"] as Map<String, dynamic>));
        break;

      case "stats":
        final stats = StatsEvent(cluster.client, node, json["data"] as Map<String, dynamic>);

        // Put the stats into the node
        (node as Node).stats = stats;

        onStatsReceivedController.add(stats);
        break;

      case "playerUpdate":
        onPlayerUpdateController.add(PlayerUpdateEvent(cluster.client, node, json["data"] as Map<String, dynamic>));
        break;
    }
  }

  @override
  Future<void> dispose() async {
    await onStatsReceivedController.close();
    await onPlayerUpdateController.close();
    await onTrackStartController.close();
    await onTrackEndController.close();
    await onWebSocketClosedController.close();
  }
}

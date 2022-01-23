import 'dart:collection';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/src/node/node.dart';
import 'package:nyxx_lavalink/src/node/node_options.dart';
import 'package:nyxx_lavalink/src/node/node_runner.dart';
import 'package:nyxx_lavalink/src/model/guild_player.dart';
import 'package:nyxx_lavalink/src/cluster_exception.dart';

import 'event_dispatcher.dart';

abstract class ICluster implements Disposable {
  /// A reference to the client
  INyxx get client;

  /// The client id provided to lavalink;
  Snowflake get clientId;

  /// Returns a map with the nodes connected to lavalink cluster
  UnmodifiableMapView<int, INode> get connectedNodes;

  /// Returns a map with the nodes that are actually disconnected from lavalink
  UnmodifiableMapView<int, INode> get disconnectedNodes;

  /// Dispatcher of all lavalink events
  late final IEventDispatcher eventDispatcher;

  /// Get the best available node, it is recommended to use [getOrCreatePlayerNode] instead
  /// as this won't create the player itself if it doesn't exists
  INode get bestNode;

  /// Attempts to get the node containing a player for a specific guild id
  ///
  /// if the player doesn't exist, then the best node is retrieved and the player created
  INode getOrCreatePlayerNode(Snowflake guildId);

  /// Attempts to retrieve a node disconnected from lavalink by its id,
  /// this method does not work with nodes that have exceeded the maximum
  /// reconnect attempts as those get removed from cluster
  INode? getDisconnectedNode(int nodeId);

  /// Adds and initializes a node
  Future<void> addNode(NodeOptions options);

  static ICluster createCluster(INyxxWebsocket client, Snowflake clientId) => Cluster(client, clientId);
}

/// Cluster of lavalink nodes
class Cluster implements ICluster {
  /// A reference to the client
  @override
  final INyxxWebsocket client;

  /// The client id provided to lavalink;
  @override
  final Snowflake clientId;

  /// All available nodes, ordered by node id
  final Map<int, INode> nodes = {};

  /// Returns a map with the nodes connected to lavalink cluster
  @override
  UnmodifiableMapView<int, INode> get connectedNodes => UnmodifiableMapView(nodes);

  /// Nodes that are currently connecting to server, when a node gets connected
  /// it will be moved to [_nodes], and when reconnecting will be moved here again
  final Map<int, INode> connectingNodes = {};

  /// Returns a map with the nodes that are actually disconnected from lavalink
  @override
  UnmodifiableMapView<int, INode> get disconnectedNodes => UnmodifiableMapView(connectingNodes);

  /// A map to keep the assigned node id for each player
  final Map<Snowflake, int> nodeLocations = {};

  /// The last id assigned to a node, this is used to avoid repeating ids
  /// since if we use a repeated id, the existing node would be overwritten and lost
  int _lastId = 0;

  final _receivePort = ReceivePort();
  late final Stream<dynamic> _receiveStream;

  final logger = Logger("Lavalink");

  @override
  late final IEventDispatcher eventDispatcher;

  Future<void> _addNode(NodeOptions nodeOptions, int nodeId) async {
    await Isolate.spawn(handleNode, _receivePort.sendPort);

    final isolateSendPort = await _receiveStream.firstWhere((element) => element is SendPort) as SendPort;

    nodeOptions.clientId = clientId;
    nodeOptions.nodeId = nodeId;

    isolateSendPort.send(nodeOptions.toJson());

    // Say the node to start the connection
    isolateSendPort.send({"cmd": "CONNECT"});

    final node = Node.fromOptions(this, nodeOptions, isolateSendPort);

    connectingNodes[nodeId] = node;
  }

  void _handleNodeMessage(dynamic message) {
    if (message is SendPort) {
      return;
    }

    final map = message as Map<String, dynamic>;

    logger.finer("Receved data from node ${map["nodeId"]}, data: $map");

    switch (map["cmd"]) {
      case "DISPATCH":
        (eventDispatcher as EventDispatcher).dispatchEvent(map);
        break;

      case "LOG":
        {
          Level? level;

          switch (map["level"]) {
            case "INFO":
              level = Level.INFO;
              break;

            case "WARNING":
              level = Level.WARNING;
              break;
          }

          logger.log(level!, map["message"]);
        }
        break;

      case "EXITED":
        {
          final nodeId = map["nodeId"]! as int;
          nodes.remove(nodeId);
          connectingNodes.remove(nodeId);

          logger.info("[Node $nodeId] Exited");
        }
        break;

      case "CONNECTED":
        {
          final node = connectingNodes.remove(map["nodeId"] as int);

          if (node != null) {
            nodes[node.options.nodeId] = node;

            logger.info("[Node ${map["nodeId"]}] Connected to lavalink");
          }
        }
        break;

      case "DISCONNECTED":
        {
          final node = nodes.remove(map["nodeId"] as int);

          if (node == null) {
            return;
          }
          connectingNodes[node.options.nodeId] = node;

          // this makes possible for a player to be moved to another node
          node.players.forEach((guildId, _) => nodeLocations.remove(guildId));

          // Also delete the players, so them can be created again on another node
          node.clearPlayers();

          logger.info("[Node ${map["nodeId"]}] Disconnected from lavalink");
        }
        break;
    }
  }

  void _registerEvents() {
    client.eventsWs.onVoiceServerUpdate.listen((event) async {
      final node = nodes[nodeLocations[event.guild.id]];
      if (node == null) {
        return;
      }

      final player = node.players[event.guild.id];
      if (player == null) {
        return;
      }

      (player as GuildPlayer).handleServerUpdate(event);
    });

    client.eventsWs.onVoiceStateUpdate.listen((event) async {
      if (event.raw["d"]["user_id"] != clientId.toString()) {
        return;
      }
      if (event.state.guild == null) {
        return;
      }

      final node = nodes[nodeLocations[event.state.guild!.id]];
      if (node == null) {
        return;
      }

      final player = node.players[event.state.guild!.id];
      if (player == null) {
        return;
      }

      (player as GuildPlayer).handleStateUpdate(event);
    });
  }

  /// Get the best available node, it is recommended to use [getOrCreatePlayerNode] instead
  /// as this won't create the player itself if it doesn't exists
  @override
  INode get bestNode {
    if (nodes.isEmpty) {
      throw ClusterException("No available nodes");
    }
    if (nodes.length == 1) {
      return nodes.values.first;
    }

    /// Node id of the node who has fewer players
    int? minNodeId;

    /// Number of players the node has
    int? minNodePlayers;

    nodes.forEach((id, node) {
      if (minNodeId == null && minNodePlayers == null) {
        minNodeId = id;
        minNodePlayers = node.players.length;
      } else {
        if (node.players.length < minNodePlayers!) {
          minNodeId = id;
          minNodePlayers = node.players.length;
        }
      }
    });

    return nodes[minNodeId]!;
  }

  /// Attempts to get the node containing a player for a specific guild id
  ///
  /// if the player doesn't exist, then the best node is retrieved and the player created
  @override
  INode getOrCreatePlayerNode(Snowflake guildId) {
    final nodePreview = nodeLocations.containsKey(guildId) ? nodes[nodeLocations[guildId]] : bestNode;

    final node = nodePreview ?? bestNode;

    if (!node.players.containsKey(guildId)) {
      node.createPlayer(guildId);
    }

    return node;
  }

  /// Attempts to retrieve a node disconnected from lavalink by its id,
  /// this method does not work with nodes that have exceeded the maximum
  /// reconnect attempts as those get removed from cluster
  @override
  INode? getDisconnectedNode(int nodeId) => connectingNodes[nodeId];

  /// Adds and initializes a node
  @override
  Future<void> addNode(NodeOptions options) async {
    /// Set a tiny delay so we can ensure we don't repeat ids
    await Future.delayed(const Duration(milliseconds: 50));

    _lastId += 1;
    await _addNode(options, _lastId);
  }

  /// Creates a new cluster ready to start adding connections
  Cluster(this.client, this.clientId) {
    _registerEvents();

    eventDispatcher = EventDispatcher(this);

    _receiveStream = _receivePort.asBroadcastStream();
    _receiveStream.listen(_handleNodeMessage);
  }

  @override
  Future<void> dispose() async {
    await eventDispatcher.dispose();
  }
}

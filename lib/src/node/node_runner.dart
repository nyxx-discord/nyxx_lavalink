import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'dart:isolate';
import 'node_options.dart';

/*
  The actual node runner
  Following nyxx design, the node communicates with the cluster using json
  First message will always be the [NodeOptions] data

  Can receive:
  * SEND - Sends a given json payload directly to the server through the web socket
  * CONNECT - Starts the connection to lavalink server
  * UPDATE - Updates the current node data
  * RECONNECT - Reconnects to lavalink server
  * DISCONNECT - Disconnects from lavalink server
  * SHUTDOWN - Shuts down the node and kills the isolate

  Can send:
  * DISPATCH - Dispatch the given event
  * DISCONNECTED - WebSocket disconnected
  * CONNECTED - WebSocket connected
  * ERROR - An error occurred
  * EXITED - Node shutdown itself
  * LOG - Log something
*/
Future<void> handleNode(SendPort clusterPort) async {
  WebSocket? socket;
  StreamSubscription<dynamic>? socketStream;

  // First thing to do is to return a send port to the cluster to communicate with the node
  final receivePort = ReceivePort();
  final receiveStream = receivePort.asBroadcastStream();
  clusterPort.send(receivePort.sendPort);

  var node = NodeOptions.fromJson(await receiveStream.first as Map<String, dynamic>);

  void process(Map<String, dynamic> json) {
    if (json["op"] == "event") {
      clusterPort.send({"cmd": "DISPATCH", "nodeId": node.nodeId, "event": json["type"], "data": json});
    } else {
      clusterPort.send({"cmd": "DISPATCH", "nodeId": node.nodeId, "event": json["op"], "data": json});
    }
  }

  Future<void> connect() async {
    final address = node.ssl ? "wss://${node.host}:${node.port}" : "ws://${node.host}:${node.port}";
    var actualAttempt = 1;

    while (actualAttempt <= node.maxConnectAttempts) {
      try {
        clusterPort.send({
          "cmd": "LOG",
          "nodeId": node.nodeId,
          "level": "INFO",
          "message": "[Node ${node.nodeId}] Trying to connect to lavalink ($actualAttempt/${node.maxConnectAttempts})"
        });

        await WebSocket.connect(address, headers: {
          "Authorization": node.password,
          "Num-Shards": node.shards,
          "User-Id": node.clientId.id,
          "Client-Name": node.clientName
        }).then((ws) {
          clusterPort.send({"cmd": "CONNECTED", "nodeId": node.nodeId});

          socket = ws;

          socketStream = socket!.listen(
              (data) {
                process(jsonDecode(data as String) as Map<String, dynamic>);
              },
              onDone: () async {
                clusterPort.send({"cmd": "DISCONNECTED", "nodeId": node.nodeId});
                await connect();

                return;
              },
              cancelOnError: true,
              onError: (err) {
                clusterPort.send({"cmd": "ERROR", "nodeId": node.nodeId, "code": socket!.closeCode, "reason": socket!.closeReason});
              });

          return;
        });

        return;
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        clusterPort
            .send({"cmd": "LOG", "nodeId": node.nodeId, "level": "WARNING", "message": "[Node ${node.nodeId}] Error while trying to connect to lavalink; $e"});
      }

      clusterPort.send({"cmd": "LOG", "nodeId": node.nodeId, "level": "WARNING", "message": "[Node ${node.nodeId}] Failed to connect to lavalink, retrying"});

      actualAttempt += 1;

      await Future.delayed(node.delayBetweenReconnections);
    }

    clusterPort.send({"cmd": "EXITED", "nodeId": node.nodeId});
  }

  Future<void> disconnect() async {
    await socket?.close(1000);
    await socketStream?.cancel();

    clusterPort.send({"cmd": "DISCONNECTED", "nodeId": node.nodeId});
  }

  Future<void> reconnect() async {
    await disconnect();
    await Future.delayed(const Duration(milliseconds: 300));
    await connect();
  }

  await for (final msg in receiveStream) {
    switch (msg["cmd"]) {
      case "SEND":
        socket?.add(jsonEncode(msg["data"]));
        break;

      case "CONNECT":
        await connect();
        break;

      case "UPDATE":
        node = NodeOptions.fromJson(msg["data"] as Map<String, dynamic>);
        await reconnect();
        break;

      case "DISCONNECT":
        await disconnect();
        break;

      case "RECONNECT":
        await reconnect();
        break;

      case "SHUTDOWN":
        {
          clusterPort.send({"cmd": "EXITED", "nodeId": node.nodeId});
          await disconnect();
          receivePort.close();
          Isolate.current.kill(priority: Isolate.immediate);
        }
        break;

      default:
        break;
    }
  }
}

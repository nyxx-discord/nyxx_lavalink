import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'package:nyxx_lavalink/src/model/stats.dart';

import '../mocks/node.mock.dart';
import '../mocks/nyxx_websocket.mock.dart';

main() {
  test("stats event deserialization", () {
    final rawData = {
      'playingPlayers': 1,
      'players': 2,
      'uptime': 60,
      'memory': {
        'reservable': 1024,
        'used': 64,
        'free': 512,
        'allocated': 256
      },
      'frameStats': {
        'sent': 1,
        'deficit': 1,
        'nulled': 1
      },
      'cpu': {
        'cores': 2,
        'systemLoad': 0.54,
        'lavalinkLoad': 0.1
      },
    };

    final resultEntity = StatsEvent(NyxxWebsocketMock(), NodeMock(), rawData);

    expect(resultEntity.players, equals(2));
    expect(resultEntity.players, equals(2));
    expect(resultEntity.uptime, equals(60));
    expect(resultEntity.memory.free, equals(512));
    expect(resultEntity.frameStats, isNotNull);
    expect(resultEntity.frameStats!.sent, equals(1));
    expect(resultEntity.cpu.systemLoad, equals(0.54));
  });
}

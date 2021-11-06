import 'package:mockito/mockito.dart';
import 'package:nyxx/nyxx.dart';

class NyxxWebsocketMock extends Fake implements INyxxWebsocket {
  @override
  String get token => "test-token";
}

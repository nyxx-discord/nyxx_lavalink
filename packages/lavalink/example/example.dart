import 'package:lavalink/lavalink.dart';

void main() async {
  final client = await LavalinkClient.connect(
    Uri.http('localhost:2333'),
    password: 'youshallnotpass',
    userId: '1',
  );

  print(await client.getVersion());

  await client.close();
}

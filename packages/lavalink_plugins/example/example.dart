import 'package:lavalink/lavalink.dart';
import 'package:lavalink_plugins/lavalink_plugins.dart';

/// An example of using the Sponsorblock plugin with Lavalink.
/// This example connects to a Lavalink server, adds the Sponsorblock plugin,
/// and listens for segment skipped events.
///
/// We assume you have a running Lavalink server with the Sponsorblock plugin installed and the youtube plugin enabled.

void main(List<String> args) async {
  final client = await LavalinkClient.connect(
    Uri.http('localhost:2333'),
    password: 'youshallnotpass',
    userId: '1',
    plugins: (client) => [
      SponsorblockPlugin(client),
    ],
  );

  final sponsorblock = client.plugins.whereType<SponsorblockPlugin>().first;

  print('Connected to Lavalink v${await client.getVersion()}');

  // Assume a voice server/state update has happened and we have a player ready

  await sponsorblock.putCategories('123456789123456789', [SegmentCategory.outro]);

  await client.updatePlayer('123456789123456789', identifier: 'https://www.youtube.com/watch?v=aqz-KE-bpKQ');

  client.connection.listen((message) {
    if (message is! LavalinkEvent) {
      return;
    }
    if (message is SegmentSkipped) {
      print('Segment has been skipped: from ${message.segment.start} to ${message.segment.end} (${message.segment.category.category})');
    }
  });
}

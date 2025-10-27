import 'dart:io';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';

void main() async {
  final lavalink = LavalinkPlugin(
    base: Uri.http('localhost:2333'),
    password: 'youshallnotpass',
  );

  final client = await Nyxx.connectGateway(
    Platform.environment['TOKEN']!,
    GatewayIntents.allUnprivileged,
    options: GatewayClientOptions(plugins: [logging, cliIntegration, lavalink]),
  );

  client.onMessageCreate.listen((event) async {
    // Mention the bot while in a voice channel to play Crab Rave
    if (!event.mentions.contains(client.user)) return;

    final voiceState = event.guild?.voiceStates[event.message.author.id];
    if (voiceState == null || voiceState.channel == null) return;

    final voiceChannel = (await voiceState.channel!.fetch()) as VoiceChannel;

    final player = await voiceChannel.connectLavalink();

    final searchResult = await lavalink.loadTrack('ytsearch:Crab Rave');

    if (searchResult is! SearchLoadResult) throw Exception('Expected search load result');
    if (searchResult.data.isEmpty) throw Exception('No tracks found');

    final track = searchResult.data.first;

    await player.play(track);

    await lavalink.onTrackEnd.firstWhere((e) => e.guildId == event.guild!.id.toString());

    await player.disconnect();
  });
}

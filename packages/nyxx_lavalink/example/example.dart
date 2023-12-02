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

    await player.playEncoded(
      // Crab Rave!!!!
      'QAAAzAMAK05vaXNlc3Rvcm0gLSBDcmFiIFJhdmUgW01vbnN0ZXJjYXQgUmVsZWFzZV0AE01vbnN0ZXJjYXQgSW5zdGluY3QAAAAAAALx6AALTERVX1R4azA2dE0AAQAraHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj1MRFVfVHhrMDZ0TQEAMGh0dHBzOi8vaS55dGltZy5jb20vdmkvTERVX1R4azA2dE0vbXFkZWZhdWx0LmpwZwAAB3lvdXR1YmUAAAAAAAAAAA==',
    );

    await lavalink.onTrackEnd.firstWhere((e) => e.guildId == event.guild!.id.toString());

    await player.disconnect();
  });
}

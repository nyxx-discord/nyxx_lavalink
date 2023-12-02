import 'package:lavalink/lavalink.dart' hide VoiceState;
import 'package:lavalink/lavalink.dart' as lavalink show VoiceState;
import 'package:nyxx/nyxx.dart';

class LavalinkPlayer implements Player {
  final NyxxGateway client;
  final LavalinkClient lavalinkClient;
  final Player player;

  LavalinkPlayer({
    required this.client,
    required this.lavalinkClient,
    required this.player,
  });

  @override
  Filters get filters => player.filters;

  @override
  String get guildId => player.guildId;

  @override
  bool get isPaused => player.isPaused;

  @override
  PlayerState get state => player.state;

  @override
  Track? get track => player.track;

  @override
  lavalink.VoiceState get voice => player.voice;

  @override
  int get volume => player.volume;

  Future<void> disconnect() async {
    await lavalinkClient.deletePlayer(guildId);
    client.gateway.updateVoiceState(
      Snowflake.parse(guildId),
      GatewayVoiceStateBuilder(
        channelId: null,
        isMuted: false,
        isDeafened: false,
      ),
    );
  }

  Future<void> play(Track track) =>
      lavalinkClient.updatePlayer(guildId, encodedTrack: track.encoded);

  Future<void> playEncoded(String encodedTrack) =>
      lavalinkClient.updatePlayer(guildId, encodedTrack: encodedTrack);

  Future<void> playIdentifier(String identifier) =>
      lavalinkClient.updatePlayer(guildId, identifier: identifier);

  Future<void> stopPlaying() => lavalinkClient.updatePlayer(guildId, encodedTrack: null);
}

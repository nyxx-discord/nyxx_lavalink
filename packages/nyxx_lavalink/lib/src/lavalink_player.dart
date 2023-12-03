import 'package:lavalink/lavalink.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/src/plugin.dart';

class LavalinkPlayer {
  final NyxxGateway client;
  final LavalinkClient lavalinkClient;
  final LavalinkPlugin plugin;

  final Snowflake guildId;

  Stream<TrackEndEvent> get onTrackEnd => plugin.onTrackEnd
      .where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient);

  Stream<TrackExceptionEvent> get onTrackException => plugin.onTrackException
      .where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient);

  Stream<TrackStartEvent> get onTrackStart => plugin.onTrackStart
      .where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient);

  Stream<TrackStuckEvent> get onTrackStuck => plugin.onTrackStuck
      .where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient);

  Stream<WebSocketClosedEvent> get onWebsocketClosed => plugin.onWebsocketClosed
      .where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient);

  Stream<PlayerUpdateMessage> get onUpdate => plugin.onPlayerUpdate
      .where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient);

  Track? get currentTrack => _currentTrack;
  Track? _currentTrack;

  PlayerState get state => _state;
  PlayerState _state = PlayerState(
    time: DateTime.timestamp(),
    position: Duration.zero,
    isConnected: false,
    ping: Duration.zero,
  );

  LavalinkPlayer({
    required this.client,
    required this.lavalinkClient,
    required this.plugin,
    required this.guildId,
  }) {
    onTrackEnd.listen((event) => _currentTrack = null);
    onTrackStart.listen((event) => _currentTrack = event.track);
    onUpdate.listen((event) => _state = event.state);
  }

  Future<Player> fetchPlayer() => lavalinkClient.getPlayer(guildId.toString());

  Future<void> disconnect() async {
    await lavalinkClient.deletePlayer(guildId.toString());
    client.gateway.updateVoiceState(
      guildId,
      GatewayVoiceStateBuilder(
        channelId: null,
        isMuted: false,
        isDeafened: false,
      ),
    );
  }

  Future<void> play(Track track) =>
      lavalinkClient.updatePlayer(guildId.toString(), encodedTrack: track.encoded);

  Future<void> playEncoded(String encodedTrack) =>
      lavalinkClient.updatePlayer(guildId.toString(), encodedTrack: encodedTrack);

  Future<void> playIdentifier(String identifier) =>
      lavalinkClient.updatePlayer(guildId.toString(), identifier: identifier);

  Future<void> stopPlaying() => lavalinkClient.updatePlayer(guildId.toString(), encodedTrack: null);

  Future<void> seekTo(Duration position) =>
      lavalinkClient.updatePlayer(guildId.toString(), position: position);

  Future<void> pause() => lavalinkClient.updatePlayer(guildId.toString(), isPaused: true);

  Future<void> resume() => lavalinkClient.updatePlayer(guildId.toString(), isPaused: false);

  Future<void> setVolume(int volume) =>
      lavalinkClient.updatePlayer(guildId.toString(), volume: volume);

  Future<void> setFilters(Filters filters) =>
      lavalinkClient.updatePlayer(guildId.toString(), filters: filters);
}

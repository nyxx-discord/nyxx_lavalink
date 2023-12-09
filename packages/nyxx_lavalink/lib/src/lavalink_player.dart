import 'dart:async';

import 'package:lavalink/lavalink.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/src/plugin.dart';

/// An internal helper that forwards events from one stream to another, but can be closed.
class StreamForwarder<T> {
  final Stream<T> sourceStream;

  late final StreamSubscription<T> subscription;
  final StreamController<T> controller = StreamController.broadcast();

  Stream<T> get stream => controller.stream;

  StreamForwarder(this.sourceStream) {
    subscription = sourceStream.listen(
      controller.add,
      onError: controller.addError,
      onDone: controller.close,
    );
  }

  Future<void> close() async {
    await subscription.cancel();
    await controller.close();
  }
}

class LavalinkPlayer {
  final NyxxGateway client;
  final LavalinkClient lavalinkClient;
  final LavalinkPlugin plugin;

  final Snowflake guildId;

  Stream<TrackEndEvent> get onTrackEnd => _onTrackEndController.stream;
  late final StreamForwarder<TrackEndEvent> _onTrackEndController = StreamForwarder(
    plugin.onTrackEnd.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  Stream<TrackExceptionEvent> get onTrackException => _onTrackExceptionController.stream;
  late final StreamForwarder<TrackExceptionEvent> _onTrackExceptionController = StreamForwarder(
    plugin.onTrackException.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  Stream<TrackStartEvent> get onTrackStart => _onTrackStartController.stream;
  late final StreamForwarder<TrackStartEvent> _onTrackStartController = StreamForwarder(
    plugin.onTrackStart.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  Stream<TrackStuckEvent> get onTrackStuck => _onTrackStuckController.stream;
  late final StreamForwarder<TrackStuckEvent> _onTrackStuckController = StreamForwarder(
    plugin.onTrackStuck.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  Stream<WebSocketClosedEvent> get onWebsocketClosed => _onWebsocketClosedController.stream;
  late final StreamForwarder<WebSocketClosedEvent> _onWebsocketClosedController = StreamForwarder(
    plugin.onWebsocketClosed.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  Stream<PlayerUpdateMessage> get onUpdate => _onUpdateController.stream;
  late final StreamForwarder<PlayerUpdateMessage> _onUpdateController = StreamForwarder(
    plugin.onPlayerUpdate.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

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

    await Future.wait([
      _onTrackEndController.close(),
      _onTrackExceptionController.close(),
      _onTrackStartController.close(),
      _onTrackStuckController.close(),
      _onWebsocketClosedController.close(),
      _onUpdateController.close(),
    ]);
  }

  Future<void> play(Track track) => lavalinkClient.updatePlayer(guildId.toString(), encodedTrack: track.encoded);

  Future<void> playEncoded(String encodedTrack) => lavalinkClient.updatePlayer(guildId.toString(), encodedTrack: encodedTrack);

  Future<void> playIdentifier(String identifier) => lavalinkClient.updatePlayer(guildId.toString(), identifier: identifier);

  Future<void> stopPlaying() => lavalinkClient.updatePlayer(guildId.toString(), encodedTrack: null);

  Future<void> seekTo(Duration position) => lavalinkClient.updatePlayer(guildId.toString(), position: position);

  Future<void> pause() => lavalinkClient.updatePlayer(guildId.toString(), isPaused: true);

  Future<void> resume() => lavalinkClient.updatePlayer(guildId.toString(), isPaused: false);

  Future<void> setVolume(int volume) => lavalinkClient.updatePlayer(guildId.toString(), volume: volume);

  Future<void> setFilters(Filters filters) => lavalinkClient.updatePlayer(guildId.toString(), filters: filters);
}

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

/// Provides methods to control and get information about a Lavalink [Player] in a voice channel.
class LavalinkPlayer {
  /// The [NyxxGateway] client this player is attached to.
  final NyxxGateway client;

  /// The [LavalinkClient] this player is attached to.
  final LavalinkClient lavalinkClient;

  /// The [LavalinkPlugin] this player is attached to.
  final LavalinkPlugin plugin;

  /// The ID of this player's guild.
  final Snowflake guildId;

  /// A stream of [TrackEndEvent]s emitted by this player.
  Stream<TrackEndEvent> get onTrackEnd => _onTrackEndController.stream;
  late final StreamForwarder<TrackEndEvent> _onTrackEndController = StreamForwarder(
    plugin.onTrackEnd.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  /// A stream of [TrackExceptionEvent]s emitted by this player.
  Stream<TrackExceptionEvent> get onTrackException => _onTrackExceptionController.stream;
  late final StreamForwarder<TrackExceptionEvent> _onTrackExceptionController = StreamForwarder(
    plugin.onTrackException.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  /// A stream of [TrackStartEvent]s emitted by this player.
  Stream<TrackStartEvent> get onTrackStart => _onTrackStartController.stream;
  late final StreamForwarder<TrackStartEvent> _onTrackStartController = StreamForwarder(
    plugin.onTrackStart.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  /// A stream of [TrackStuckEvent]s emitted by this player.
  Stream<TrackStuckEvent> get onTrackStuck => _onTrackStuckController.stream;
  late final StreamForwarder<TrackStuckEvent> _onTrackStuckController = StreamForwarder(
    plugin.onTrackStuck.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  /// A stream of [WebSocketClosedEvent]s emitted by this player.
  Stream<WebSocketClosedEvent> get onWebsocketClosed => _onWebsocketClosedController.stream;
  late final StreamForwarder<WebSocketClosedEvent> _onWebsocketClosedController = StreamForwarder(
    plugin.onWebsocketClosed.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  /// A stream of [PlayerUpdateMessage]s emitted by this player.
  Stream<PlayerUpdateMessage> get onUpdate => _onUpdateController.stream;
  late final StreamForwarder<PlayerUpdateMessage> _onUpdateController = StreamForwarder(
    plugin.onPlayerUpdate.where((event) => event.guildId == guildId.toString() && event.client == lavalinkClient),
  );

  /// The currently playing track.
  Track? get currentTrack => _currentTrack;
  Track? _currentTrack;

  /// The current state of this player.
  PlayerState get state => _state;
  PlayerState _state = PlayerState(
    time: DateTime.timestamp(),
    position: Duration.zero,
    isConnected: false,
    ping: Duration.zero,
  );

  /// Create a new [LavalinkPlayer].
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

  /// Fetch the underlying Lavalink [Player] this [LavalinkPlayer] instance represents.
  Future<Player> fetchPlayer() => lavalinkClient.getPlayer(guildId.toString());

  /// Disconnect this player from the voice channel and destroy it.
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

  /// Play a track in the voice channel.
  Future<void> play(Track track) => lavalinkClient.updatePlayer(guildId.toString(), encodedTrack: track.encoded);

  /// Play a track in the voice channel using the track's encoded representation.
  Future<void> playEncoded(String encodedTrack) => lavalinkClient.updatePlayer(guildId.toString(), encodedTrack: encodedTrack);

  /// Play a track in the voice channel by the track's identifier.
  Future<void> playIdentifier(String identifier) => lavalinkClient.updatePlayer(guildId.toString(), identifier: identifier);

  /// Stop the currently playing track.
  Future<void> stopPlaying() => lavalinkClient.updatePlayer(guildId.toString(), encodedTrack: null);

  /// Seek to the provided [position] in the currently playing track.
  Future<void> seekTo(Duration position) => lavalinkClient.updatePlayer(guildId.toString(), position: position);

  /// Pause the currently playing track.
  Future<void> pause() => lavalinkClient.updatePlayer(guildId.toString(), isPaused: true);

  /// Resume playing the current track.
  Future<void> resume() => lavalinkClient.updatePlayer(guildId.toString(), isPaused: false);

  /// Set this player's volume.
  Future<void> setVolume(int volume) => lavalinkClient.updatePlayer(guildId.toString(), volume: volume);

  /// Set the filters this player uses.
  Future<void> setFilters(Filters filters) => lavalinkClient.updatePlayer(guildId.toString(), filters: filters);
}

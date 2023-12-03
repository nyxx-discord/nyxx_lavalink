import 'dart:async';

import 'package:lavalink/lavalink.dart' hide VoiceState;
import 'package:lavalink/lavalink.dart' as lavalink show VoiceState;
import 'package:nyxx/nyxx.dart';

import 'package:nyxx_lavalink/src/lavalink_player.dart';

/// An internal extension adding utility methods to [Stream].
extension StreamExtension<T> on Stream<T> {
  /// Equivalent to [Iterable.whereType].
  Stream<U> whereType<U>() => where((event) => event is U).cast<U>();
}

class LavalinkPlugin extends NyxxPlugin<NyxxGateway> {
  static const version = '0.0.0';
  static const clientName = 'nyxx_lavalink/$version';

  final Uri base;
  final String password;
  final LavalinkClient? innerClient;

  final StreamController<LavalinkMessage> _messagesController = StreamController.broadcast();
  Stream<LavalinkMessage> get onMessage => _messagesController.stream;

  Stream<StatsMessage> get onStats => onMessage.whereType<StatsMessage>();
  Stream<LavalinkReadyMessage> get onReady => onMessage.whereType<LavalinkReadyMessage>();
  Stream<PlayerUpdateMessage> get onPlayerUpdate => onMessage.whereType<PlayerUpdateMessage>();
  Stream<LavalinkEvent> get onEvent => onMessage.whereType<LavalinkEvent>();

  Stream<TrackEndEvent> get onTrackEnd => onEvent.whereType<TrackEndEvent>();
  Stream<TrackExceptionEvent> get onTrackException => onEvent.whereType<TrackExceptionEvent>();
  Stream<TrackStartEvent> get onTrackStart => onEvent.whereType<TrackStartEvent>();
  Stream<TrackStuckEvent> get onTrackStuck => onEvent.whereType<TrackStuckEvent>();
  Stream<WebSocketClosedEvent> get onWebsocketClosed => onEvent.whereType<WebSocketClosedEvent>();

  final StreamController<LavalinkPlayer> _playerConnectedController = StreamController.broadcast();
  Stream<LavalinkPlayer> get onPlayerConnected => _playerConnectedController.stream;

  LavalinkPlugin({
    required this.base,
    required this.password,
    this.innerClient,
  });

  @override
  NyxxPluginState<NyxxGateway, LavalinkPlugin> createState() => _LavalinkPluginState(this);
}

class _LavalinkPluginState extends NyxxPluginState<NyxxGateway, LavalinkPlugin> {
  LavalinkClient? lavalinkClient;

  final Map<Snowflake, VoiceState> _voiceStates = {};
  final Map<Snowflake, VoiceServerUpdateEvent> _voiceServers = {};

  _LavalinkPluginState(super.plugin);

  @override
  Future<void> afterConnect(NyxxGateway client) async {
    await super.afterConnect(client);

    lavalinkClient = plugin.innerClient ??
        await LavalinkClient.connect(
          plugin.base,
          password: plugin.password,
          userId: client.user.id.toString(),
          clientName: LavalinkPlugin.clientName,
        );

    lavalinkClient!.connection.listen(
      plugin._messagesController.add,
      onError: plugin._messagesController.addError,
      cancelOnError: false,
    );

    client.onVoiceServerUpdate.listen((event) {
      _voiceServers[event.guildId] = event;
      _tryUpdateVoiceState(client, event.guildId);
    });

    client.onVoiceStateUpdate.listen((event) async {
      if (event.state.userId != client.user.id) return;

      final guildId = event.state.guildId;
      if (guildId == null) return;

      if (event.state.channelId == null) {
        _voiceStates.remove(guildId);
        _voiceServers.remove(guildId);
        await lavalinkClient!.deletePlayer(guildId.toString());
      } else {
        _voiceStates[guildId] = event.state;
        _tryUpdateVoiceState(client, guildId);
      }
    });

    client.onGuildCreate.listen((event) {
      if (event is! GuildCreateEvent) return;

      for (final state in event.voiceStates) {
        if (state.userId != client.user.id) continue;

        _voiceStates[event.guild.id] = state;
        _tryUpdateVoiceState(client, event.guild.id);
        break;
      }
    });

    client.onGuildDelete.listen((event) {
      if (event.isUnavailable) return;

      _voiceServers.remove(event.guild.id);
      _voiceStates.remove(event.guild.id);
    });
  }

  Future<void> _tryUpdateVoiceState(NyxxGateway client, Snowflake guildId) async {
    final voiceState = _voiceStates[guildId];
    final voiceServer = _voiceServers[guildId];

    if (voiceState == null || voiceServer == null) return;

    if (voiceServer.endpoint == null) {
      // TODO: Handle this case properly
      return;
    }

    final player = await lavalinkClient!.updatePlayer(
      guildId.toString(),
      voice: lavalink.VoiceState(
        endpoint: voiceServer.endpoint!,
        sessionId: voiceState.sessionId,
        token: voiceServer.token,
      ),
    );

    plugin._playerConnectedController.add(LavalinkPlayer(
      client: client,
      lavalinkClient: lavalinkClient!,
      player: player,
    ));
  }

  @override
  Future<void> beforeClose(NyxxGateway client) async {
    await super.beforeClose(client);
    await lavalinkClient!.close();
  }
}

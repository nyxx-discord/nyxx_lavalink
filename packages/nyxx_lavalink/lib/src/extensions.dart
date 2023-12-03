import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/src/lavalink_player.dart';
import 'package:nyxx_lavalink/src/plugin.dart';

final Expando<LavalinkPlugin> _clientMapping = Expando('Lavalink plugin mapping');
LavalinkPlugin _pluginFromClient(NyxxGateway client) {
  if (_clientMapping[client] case final plugin?) {
    return plugin;
  }

  for (final plugin in client.options.plugins) {
    if (plugin is! LavalinkPlugin) continue;

    _clientMapping[client] = plugin;
    return plugin;
  }

  throw StateError('No LavalinkPlugin found on client ${client.options.loggerName}');
}

NyxxGateway _ensureGateway(Nyxx client) {
  if (client is NyxxGateway) {
    return client;
  }

  throw StateError('Lavalink was used on ${client.runtimeType} (only NyxxGateway is supported)');
}

extension LavalinkVoiceChannel on VoiceChannel {
  Future<LavalinkPlayer> connectLavalink() async {
    final client = _ensureGateway(manager.client);
    final plugin = _pluginFromClient(client);

    final guildId = switch (this) {
      GuildChannel(:final guildId) => guildId,
      _ => throw 'nope', // TODO: Handle properly
    };

    client.gateway.updateVoiceState(
      guildId,
      GatewayVoiceStateBuilder(
        channelId: id,
        isMuted: false,
        isDeafened: false,
      ),
    );

    return await plugin.onPlayerConnected.firstWhere((player) => player.guildId == guildId);
  }
}

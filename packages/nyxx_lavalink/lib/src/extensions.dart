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

/// Utilities for connecting to a voice channel using Lavalink.
extension LavalinkVoiceChannel on VoiceChannel {
  /// Connect to this voice channel using Lavalink.
  ///
  /// The returned [LavalinkPlayer] can be used to control the player in the channel.
  Future<LavalinkPlayer> connectLavalink() async {
    final client = _ensureGateway(manager.client);
    final plugin = _pluginFromClient(client);

    final guildId = switch (this) {
      GuildChannel(:final guildId) => guildId,
      _ => throw UnsupportedError('Cannot connect to Lavalink outside of a guild'),
    };

    return await plugin.connect(client, id, guildId);
  }
}

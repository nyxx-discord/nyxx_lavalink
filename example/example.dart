import "dart:io";

import "package:nyxx_lavalink/nyxx_lavalink.dart";
import "package:nyxx/nyxx.dart";

void main() async {
  final client = NyxxFactory.createNyxxWebsocket("<TOKEN>", GatewayIntents.allUnprivileged)
    ..registerPlugin(Logging()) // Default logging plugin
    ..registerPlugin(CliIntegration()) // Cli integration for nyxx allows stopping application via SIGTERM and SIGKILl
    ..registerPlugin(IgnoreExceptions()) // Plugin that handles uncaught exceptions that may occur
    ..connect();

  final cluster = ICluster.createCluster(client, Snowflake("YOUR_BOT_ID"));

  // This is a really simple example, so we'll define the guild and
  // the channel where the bot will play music on
  final guildId = Snowflake("GUILD_ID_HERE");
  final channelId = Snowflake("CHANNEL_ID_HERE");

  // Add your lava link nodes. Empty constructor assumes default settings to lavalink.
  await cluster.addNode(NodeOptions());

  await for (final msg in client.eventsWs.onMessageReceived) {
    if(msg.message.content == "!join") {
      final channel = await client.fetchChannel<IVoiceGuildChannel>(channelId);

      // Create lava link node for guild
      cluster.getOrCreatePlayerNode(guildId);

      // Connect to channel
      channel.connect();
    } else if(msg.message.content == "!queue") {
      // Fetch node for guild
      final node = cluster.getOrCreatePlayerNode(guildId);

      // get player for guild
      final player = node.players[guildId];

      print(player!.queue);
    } else if (msg.message.content == "!skip") {
      final node = cluster.getOrCreatePlayerNode(guildId);

      // skip the current track, if it's the last on the queue, the
      // player will stop automatically
      node.skip(guildId);
    } else if(msg.message.content == "!nodes") {
      print("${cluster.connectedNodes.length} available nodes");
    } else if (msg.message.content == "!update") {
      final node = cluster.getOrCreatePlayerNode(guildId);

      node.updateOptions(NodeOptions());
    } else {
      // Any other message will be processed as potential title to play lava link
      final node = cluster.getOrCreatePlayerNode(guildId);

      // search for given query using lava link
      final searchResults = await node.searchTracks(msg.message.content);

      // add found song to queue and play
      node.play(guildId, searchResults.tracks[0]).queue();
    }
  }
}

# nyxx_lavalink

[![Discord Shield](https://discordapp.com/api/guilds/846136758470443069/widget.png?style=shield)](https://discord.gg/nyxx)
[![pub](https://img.shields.io/pub/v/nyxx.svg)](https://pub.dartlang.org/packages/nyxx_lavalink)
[![documentation](https://img.shields.io/badge/Documentation-nyxx_interactions-yellow.svg)](https://www.dartdocs.org/documentation/nyxx_lavalink/latest/)

Simple, robust framework for creating discord bots for Dart language.

<hr />

### Features

- **Lavalink support** <br>
  Nyxx allows you to create music bots by adding support to [Lavalink](https://github.com/freyacodes/Lavalink) API
- **Fine Control** <br>
  Nyxx allows you to control every outgoing HTTP request or WebSocket message.

## Quick example

Lavalink
```dart
void main() async {
  final bot = NyxxFactory.createNyxxWebsocket("<TOKEN>", GatewayIntents.allUnprivileged);

  final guildId = Snowflake("GUILD_ID");
  final channelId = Snowflake("CHANNEL_ID");

  final cluster = ICluster.createCluster(bot, Snowflake("BOT_ID"));
  await cluster.addNode(NodeOptions());

  bot.eventsWs.onMessageReceived.listen((event) async {
    if (event.message.content == "!join") {
      final channel = await bot.fetchChannel<IVoiceGuildChannel>(channelId);

      cluster.getOrCreatePlayerNode(guildId);

      channel.connect();
    } else {
      final node = cluster.getOrCreatePlayerNode(guildId);

      final searchResults = await node.searchTracks(event.message.content);

      node.play(guildId, searchResults.tracks[0]).queue();
    }
  });
}
```

## Other nyxx packages

- [nyxx](https://github.com/nyxx-discord/nyxx)
- [nyxx_interactions](https://github.com/nyxx-discord/nyxx_interactions)
- [nyxx_extensions](https://github.com/nyxx-discord/nyxx_extensions)
- [nyxx_commander](https://github.com/nyxx-discord/nyxx_commander)
- [nyxx_pagination](https://github.com/nyxx-discord/nyxx_pagination)

## More examples

Nyxx examples can be found [here](https://github.com/nyxx-discord/nyxx_lavalink/tree/dev/example).

### Example bots
- [Running on Dart](https://github.com/l7ssha/running_on_dart)

## Documentation, help and examples

**Dartdoc documentation for latest stable version is hosted on [pub](https://www.dartdocs.org/documentation/nyxx_lavalink/latest/)**

#### [Docs and wiki](https://nyxx.l7ssha.xyz)
You can read docs and wiki articles for latest stable version on my website. This website also hosts docs for latest
dev changes to framework (`dev` branch)

#### [Official nyxx discord server](https://discord.gg/nyxx)
If you need assistance in developing bot using nyxx you can join official nyxx discord guild.

#### [Discord API docs](https://discordapp.com/developers/docs/intro)
Discord API documentation features rich descriptions about all topics that nyxx covers.

#### [Discord API Guild](https://discord.gg/discord-api)
The unofficial guild for Discord Bot developers. To get help with nyxx check `#dart_nyxx` channel.

#### [Dartdocs](https://www.dartdocs.org/documentation/nyxx_lavalink/latest/)
The dartdocs page will always have the documentation for the latest release.

## Contributing to Nyxx

Read [contributing document](https://github.com/nyxx-discord/nyxx_lavalink/blob/dev/CONTRIBUTING.md)

## Credits

* [Hackzzila's](https://github.com/Hackzzila) for [nyx](https://github.com/Hackzzila/nyx).

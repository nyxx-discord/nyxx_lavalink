import 'package:lavalink/src/messages/message.dart';

abstract class LavalinkEvent extends LavalinkMessage {
  final String type;
  final String guildId;

  LavalinkEvent({
    required super.client,
    required super.opType,
    required this.type,
    required this.guildId,
  });
}

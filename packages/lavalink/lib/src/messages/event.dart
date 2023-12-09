import 'package:lavalink/src/messages/message.dart';

/// An event sent by a Lavalink server.
abstract class LavalinkEvent extends LavalinkMessage {
  /// The type of this event.
  final String type;

  /// The ID of the guild this event occurred in.
  final String guildId;

  /// Create a new [LavalinkEvent].
  LavalinkEvent({
    required super.client,
    required super.opType,
    required this.type,
    required this.guildId,
  });
}

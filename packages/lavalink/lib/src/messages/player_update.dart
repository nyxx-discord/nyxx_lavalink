import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/player_state.dart';

part 'player_update.g.dart';

/// A message sent when a [Player] changes state.
@JsonSerializable()
class PlayerUpdateMessage extends LavalinkMessage {
  /// The ID of the guild the player is in.
  final String guildId;

  /// The state of the player.
  final PlayerState state;

  /// Create a new [PlayerUpdateMessage].
  PlayerUpdateMessage({
    required super.client,
    required super.opType,
    required this.guildId,
    required this.state,
  });

  factory PlayerUpdateMessage.fromJson(Map<String, Object?> json) => _$PlayerUpdateMessageFromJson(json);
}

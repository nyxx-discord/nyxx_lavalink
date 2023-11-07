import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/player_state.dart';

part 'player_update.g.dart';

@JsonSerializable()
class PlayerUpdateMessage extends LavalinkMessage {
  final String guildId;
  final PlayerState state;

  PlayerUpdateMessage({
    required super.client,
    required super.opType,
    required this.guildId,
    required this.state,
  });

  factory PlayerUpdateMessage.fromJson(Map<String, Object?> json) =>
      _$PlayerUpdateMessageFromJson(json);
}

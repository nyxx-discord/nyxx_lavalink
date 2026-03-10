import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/utils/deserializing_utils.dart';

part 'player_state.g.dart';

/// The current state of a [Player].
@JsonSerializable()
class PlayerState {
  /// The current time for this player.
  @JsonKey(fromJson: dateTimeFromMilliseconds)
  final DateTime time;

  /// The position of the current track.
  @JsonKey(fromJson: durationFromMilliseconds)
  final Duration position;

  /// Whether the player is connected.
  @JsonKey(name: 'connected')
  final bool isConnected;

  /// The player's ping.
  @JsonKey(fromJson: durationFromMilliseconds)
  final Duration ping;

  /// Create a new [PlayerState].
  PlayerState({
    required this.time,
    required this.position,
    required this.isConnected,
    required this.ping,
  });

  factory PlayerState.fromJson(Map<String, Object?> json) => _$PlayerStateFromJson(json);
}

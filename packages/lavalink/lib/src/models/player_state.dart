import 'package:json_annotation/json_annotation.dart';

part 'player_state.g.dart';

DateTime _dateTimeFromMilliseconds(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);
Duration _durationFromMilliseconds(int ms) => Duration(milliseconds: ms);

/// The current state of a [Player].
@JsonSerializable()
class PlayerState {
  /// The current time for this player.
  @JsonKey(fromJson: _dateTimeFromMilliseconds)
  final DateTime time;

  /// The position of the current track.
  @JsonKey(fromJson: _durationFromMilliseconds)
  final Duration position;

  /// Whether the player is connected.
  @JsonKey(name: 'connected')
  final bool isConnected;

  /// The player's ping.
  @JsonKey(fromJson: _durationFromMilliseconds)
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

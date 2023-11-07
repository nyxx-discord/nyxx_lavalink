import 'package:json_annotation/json_annotation.dart';

part 'player_state.g.dart';

DateTime _dateTimeFromMilliseconds(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);
Duration _durationFromMilliseconds(int ms) => Duration(milliseconds: ms);

@JsonSerializable()
class PlayerState {
  @JsonKey(fromJson: _dateTimeFromMilliseconds)
  final DateTime time;
  @JsonKey(fromJson: _durationFromMilliseconds)
  final Duration position;
  @JsonKey(name: 'connected')
  final bool isConnected;
  @JsonKey(fromJson: _durationFromMilliseconds)
  final Duration ping;

  PlayerState({
    required this.time,
    required this.position,
    required this.isConnected,
    required this.ping,
  });

  factory PlayerState.fromJson(Map<String, Object?> json) => _$PlayerStateFromJson(json);
}

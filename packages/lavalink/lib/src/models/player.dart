import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/models/filters.dart';
import 'package:lavalink/src/models/player_state.dart';
import 'package:lavalink/src/models/track.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  final String guildId;
  final Track? track;
  final int volume;
  @JsonKey(name: 'paused')
  final bool isPaused;
  final PlayerState state;
  final VoiceState voice;
  final Filters filters;

  Player({
    required this.guildId,
    required this.track,
    required this.volume,
    required this.isPaused,
    required this.state,
    required this.voice,
    required this.filters,
  });

  factory Player.fromJson(Map<String, Object?> json) => _$PlayerFromJson(json);
}

@JsonSerializable(createToJson: true)
class VoiceState {
  final String token;
  final String endpoint;
  final String sessionId;

  VoiceState({required this.token, required this.endpoint, required this.sessionId});

  factory VoiceState.fromJson(Map<String, Object?> json) => _$VoiceStateFromJson(json);

  Map<String, Object?> toJson() => _$VoiceStateToJson(this);
}

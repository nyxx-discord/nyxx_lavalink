import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/models/filters.dart';
import 'package:lavalink/src/models/player_state.dart';
import 'package:lavalink/src/models/track.dart';

part 'player.g.dart';

/// The state of the client playing audio in a guild.
@JsonSerializable()
class Player {
  /// The ID of the guild.
  final String guildId;

  /// The currently playing track.
  final Track? track;

  /// The current volume.
  final int volume;

  /// Whether this player is currently paused.
  @JsonKey(name: 'paused')
  final bool isPaused;

  /// The state of this player.
  final PlayerState state;

  /// The state of this player's voice session.
  final VoiceState voice;

  /// The filters used by this player.
  final Filters filters;

  /// Create a new [Player].
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

/// The state of a [Player]'s voice session.
@JsonSerializable(createToJson: true)
class VoiceState {
  /// The voice token being used.
  final String token;

  /// The endpoint being used.
  final String endpoint;

  /// The ID of the voice session.
  final String sessionId;

  /// Create a new [VoiceState].
  VoiceState({required this.token, required this.endpoint, required this.sessionId});

  factory VoiceState.fromJson(Map<String, Object?> json) => _$VoiceStateFromJson(json);

  Map<String, Object?> toJson() => _$VoiceStateToJson(this);
}

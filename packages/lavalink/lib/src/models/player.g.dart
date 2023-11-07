// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      guildId: json['guildId'] as String,
      track: json['track'] == null
          ? null
          : Track.fromJson(json['track'] as Map<String, dynamic>),
      volume: json['volume'] as int,
      isPaused: json['paused'] as bool,
      state: PlayerState.fromJson(json['state'] as Map<String, dynamic>),
      voice: VoiceState.fromJson(json['voice'] as Map<String, dynamic>),
      filters: Filters.fromJson(json['filters'] as Map<String, dynamic>),
    );

VoiceState _$VoiceStateFromJson(Map<String, dynamic> json) => VoiceState(
      token: json['token'] as String,
      endpoint: json['endpoint'] as String,
      sessionId: json['sessionId'] as String,
    );

Map<String, dynamic> _$VoiceStateToJson(VoiceState instance) =>
    <String, dynamic>{
      'token': instance.token,
      'endpoint': instance.endpoint,
      'sessionId': instance.sessionId,
    };

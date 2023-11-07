// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackStartEvent _$TrackStartEventFromJson(Map<String, dynamic> json) =>
    TrackStartEvent(
      client: identity(json['client'] as LavalinkClient),
      opType: json['op'] as String,
      type: json['type'] as String,
      guildId: json['guildId'] as String,
      track: Track.fromJson(json['track'] as Map<String, dynamic>),
    );

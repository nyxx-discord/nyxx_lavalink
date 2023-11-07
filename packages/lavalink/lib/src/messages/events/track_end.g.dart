// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_end.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackEndEvent _$TrackEndEventFromJson(Map<String, dynamic> json) =>
    TrackEndEvent(
      client: identity(json['client'] as LavalinkClient),
      opType: json['op'] as String,
      type: json['type'] as String,
      guildId: json['guildId'] as String,
      track: Track.fromJson(json['track'] as Map<String, dynamic>),
      reason: json['reason'] as String,
    );

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_stuck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackStuckEvent _$TrackStuckEventFromJson(Map<String, dynamic> json) =>
    TrackStuckEvent(
      client: identity(json['client'] as LavalinkClient),
      opType: json['op'] as String,
      type: json['type'] as String,
      guildId: json['guildId'] as String,
      track: Track.fromJson(json['track'] as Map<String, dynamic>),
      threshold: Duration(microseconds: json['threshold'] as int),
    );

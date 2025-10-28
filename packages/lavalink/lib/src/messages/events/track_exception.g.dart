// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackExceptionEvent _$TrackExceptionEventFromJson(Map<String, dynamic> json) => TrackExceptionEvent(
      client: identity(json['client'] as LavalinkClient),
      opType: json['op'] as String,
      type: json['type'] as String,
      guildId: json['guildId'] as String,
      track: Track.fromJson(json['track'] as Map<String, dynamic>),
      exception: ExceptionInfo.fromJson(json['exception'] as Map<String, dynamic>),
    );

ExceptionInfo _$ExceptionInfoFromJson(Map<String, dynamic> json) => ExceptionInfo(
      message: json['message'] as String?,
      severity: json['severity'] as String,
      cause: json['cause'] as String,
    );

import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/track.dart';

part 'track_exception.g.dart';

@JsonSerializable()
class TrackExceptionEvent extends LavalinkEvent {
  final Track track;
  final ExceptionInfo exception;

  TrackExceptionEvent({
    required super.client,
    required super.opType,
    required super.type,
    required super.guildId,
    required this.track,
    required this.exception,
  });

  factory TrackExceptionEvent.fromJson(Map<String, Object?> json) => _$TrackExceptionEventFromJson(json);
}

@JsonSerializable()
class ExceptionInfo {
  final String? message;
  final String severity;
  final String cause;

  ExceptionInfo({required this.message, required this.severity, required this.cause});

  factory ExceptionInfo.fromJson(Map<String, Object?> json) => _$ExceptionInfoFromJson(json);
}

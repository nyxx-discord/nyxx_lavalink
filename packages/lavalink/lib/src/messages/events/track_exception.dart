import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/track.dart';

part 'track_exception.g.dart';

/// An event sent when an exception is encountered while playing a track.
@JsonSerializable()
class TrackExceptionEvent extends LavalinkEvent {
  /// The track that was playing.
  final Track track;

  /// Information about the exception.
  final ExceptionInfo exception;

  /// Create a new [TrackExceptionEvent].
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

/// Information about an exception encountered by Lavalink.
@JsonSerializable()
class ExceptionInfo {
  /// A message describing the exception.
  final String? message;

  /// The severity of the exception.
  final String severity;

  /// The cause of the exception.
  final String cause;

  /// Create a new [ExceptionInfo].
  ExceptionInfo({required this.message, required this.severity, required this.cause});

  factory ExceptionInfo.fromJson(Map<String, Object?> json) => _$ExceptionInfoFromJson(json);
}

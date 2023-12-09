import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/message.dart';

part 'ready.g.dart';

/// A message sent when a Lavalink session is initialized.
@JsonSerializable()
class LavalinkReadyMessage extends LavalinkMessage {
  /// Whether the session was resumed.
  @JsonKey(name: 'resumed')
  final bool wasResumed;

  /// The ID of the session.
  final String sessionId;

  /// Create a new [LavalinkReadyMessage].
  LavalinkReadyMessage({
    required super.client,
    required super.opType,
    required this.wasResumed,
    required this.sessionId,
  });

  factory LavalinkReadyMessage.fromJson(Map<String, Object?> json) => _$LavalinkReadyMessageFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/message.dart';

part 'ready.g.dart';

@JsonSerializable()
class LavalinkReadyMessage extends LavalinkMessage {
  @JsonKey(name: 'resumed')
  final bool wasResumed;
  final String sessionId;

  LavalinkReadyMessage({
    required super.client,
    required super.opType,
    required this.wasResumed,
    required this.sessionId,
  });

  factory LavalinkReadyMessage.fromJson(Map<String, Object?> json) =>
      _$LavalinkReadyMessageFromJson(json);
}

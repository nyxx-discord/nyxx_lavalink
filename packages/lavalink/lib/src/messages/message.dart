import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';

LavalinkClient identity(LavalinkClient t) => t;

/// The base class for all messages sent on a [LavalinkConnection].
abstract class LavalinkMessage {
  /// The client this message was for.
  @JsonKey(fromJson: identity)
  final LavalinkClient client;

  /// The type of this message.
  @JsonKey(name: 'op')
  final String opType;

  /// Create a new [LavalinkMessage].
  LavalinkMessage({required this.client, required this.opType});
}

import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';

LavalinkClient identity(LavalinkClient t) => t;

abstract class LavalinkMessage {
  @JsonKey(fromJson: identity)
  final LavalinkClient client;
  @JsonKey(name: 'op')
  final String opType;

  LavalinkMessage({required this.client, required this.opType});
}

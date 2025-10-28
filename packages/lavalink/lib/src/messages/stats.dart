import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/stats.dart';

part 'stats.g.dart';

dynamic _readFromSelf(Map<dynamic, dynamic> json, String key) => json;

/// A message containing statistics about the server.
@JsonSerializable()
class StatsMessage extends LavalinkMessage {
  /// The statistics.
  @JsonKey(readValue: _readFromSelf)
  final LavalinkStats stats;

  /// Create a new [StatsMessage].
  StatsMessage({
    required super.client,
    required super.opType,
    required this.stats,
  });

  factory StatsMessage.fromJson(Map<String, Object?> json) => _$StatsMessageFromJson(json);
}

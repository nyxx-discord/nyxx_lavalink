import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/message.dart';
import 'package:lavalink/src/models/stats.dart';

part 'stats.g.dart';

dynamic _readFromSelf(Map<dynamic, dynamic> json, String key) => json;

@JsonSerializable()
class StatsMessage extends LavalinkMessage {
  @JsonKey(readValue: _readFromSelf)
  final LavalinkStats stats;

  StatsMessage({
    required super.client,
    required super.opType,
    required this.stats,
  });

  factory StatsMessage.fromJson(Map<String, Object?> json) => _$StatsMessageFromJson(json);
}

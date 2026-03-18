import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/lavalink.dart';
import 'package:lavalink_plugins/src/sponsorblock/models/chapter.dart';

part 'chapters_loaded.g.dart';

/// Fired when a new chapter starts.
@JsonSerializable()
class ChaptersLoaded extends LavalinkEvent {
  /// The chapters that were loaded.
  final List<Chapter> chapters;

  ChaptersLoaded({required super.client, required super.guildId, required super.opType, required super.type, required this.chapters});

  factory ChaptersLoaded.fromJson(Map<String, Object?> json) => _$ChaptersLoadedFromJson(json);
}

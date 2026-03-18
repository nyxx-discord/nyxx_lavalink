import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/lavalink.dart';
import 'package:lavalink_plugins/src/sponsorblock/models/chapter.dart';

part 'chapter_started.g.dart';

/// Fired when a new chapter starts.
@JsonSerializable()
class ChapterStarted extends LavalinkEvent {
  /// The chapter that's started.
  final Chapter chapter;

  ChapterStarted({required super.client, required super.guildId, required super.opType, required super.type, required this.chapter});

  factory ChapterStarted.fromJson(Map<String, Object?> json) => _$ChapterStartedFromJson(json);
}

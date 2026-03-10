import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/lavalink.dart';
import 'package:lavalink_plugins/src/lavalyrics/models/lyric_line.dart';

part 'lyrics_line_event.g.dart';

/// Fired when a new lyrics line is reached for a track.
@JsonSerializable()
class LyricsLineEvent extends LavalinkEvent {
  /// The index of the line in the lyrics lines list.
  final int lineIndex;

  /// The lyrics line object containing the line and metadata.
  final List<LyricLine> line;

  /// Whether the line was skipped due to seeking.
  @JsonKey(name: 'skipped')
  final bool hasBeenSkipped;

  LyricsLineEvent({
    required super.client,
    required super.opType,
    required super.type,
    required super.guildId,
    required this.hasBeenSkipped,
    required this.line,
    required this.lineIndex,
  });

  factory LyricsLineEvent.fromJson(Map<String, Object?> json) => _$LyricsLineEventFromJson(json);
}

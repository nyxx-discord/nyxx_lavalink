import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/lavalink.dart';

part 'lyrics_not_found_event.g.dart';

/// Fired when no lyrics were found for a track.
@JsonSerializable()
class LyricsNotFoundEvent extends LavalinkEvent {
  LyricsNotFoundEvent({
    required super.client,
    required super.opType,
    required super.type,
    required super.guildId,
  });

  factory LyricsNotFoundEvent.fromJson(Map<String, Object?> json) => _$LyricsNotFoundEventFromJson(json);
}

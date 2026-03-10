import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/lavalink.dart';
import 'package:lavalink_plugins/src/lavalyrics/models/lyrics.dart';

part 'lyrics_found_event.g.dart';

/// Fired when lyrics are found for a track and about to be sent to the client.
@JsonSerializable()
class LyricsFoundEvent extends LavalinkEvent {
  /// The lyrics object containing the lyrics lines and metadata.
  final Lyrics lyrics;

  LyricsFoundEvent({required super.client, required super.opType, required super.type, required super.guildId, required this.lyrics});

  factory LyricsFoundEvent.fromJson(Map<String, Object?> json) => _$LyricsFoundEventFromJson(json);
}

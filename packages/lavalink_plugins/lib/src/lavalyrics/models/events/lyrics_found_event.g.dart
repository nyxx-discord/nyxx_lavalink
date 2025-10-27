// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_found_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LyricsFoundEvent _$LyricsFoundEventFromJson(Map<String, dynamic> json) =>
    LyricsFoundEvent(
      client: identity(json['client'] as LavalinkClient),
      opType: json['op'] as String,
      type: json['type'] as String,
      guildId: json['guildId'] as String,
      lyrics: Lyrics.fromJson(json['lyrics'] as Map<String, dynamic>),
    );

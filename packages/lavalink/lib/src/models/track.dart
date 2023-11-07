import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

Duration _durationFromMilliseconds(int ms) => Duration(milliseconds: ms);

@JsonSerializable()
class Track {
  final String encoded;
  final TrackInfo info;
  final Map<String, Object?> pluginInfo;

  Track({required this.encoded, required this.info, required this.pluginInfo});

  factory Track.fromJson(Map<String, Object?> json) => _$TrackFromJson(json);
}

@JsonSerializable()
class TrackInfo {
  final String identifier;
  final bool isSeekable;
  final String author;
  @JsonKey(fromJson: _durationFromMilliseconds)
  final Duration length;
  final bool isStream;
  @JsonKey(fromJson: _durationFromMilliseconds)
  final Duration position;
  final String title;
  final Uri? uri;
  final Uri? artworkUrl;
  final String? isrc;
  final String sourceName;

  TrackInfo({
    required this.identifier,
    required this.isSeekable,
    required this.author,
    required this.length,
    required this.isStream,
    required this.position,
    required this.title,
    required this.uri,
    required this.artworkUrl,
    required this.isrc,
    required this.sourceName,
  });

  factory TrackInfo.fromJson(Map<String, Object?> json) => _$TrackInfoFromJson(json);
}

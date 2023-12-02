import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

Duration _durationFromMilliseconds(int ms) => Duration(milliseconds: ms);

/// An audio track.
@JsonSerializable()
class Track {
  /// The encoded version of this track.
  final String encoded;

  /// Information about this track.
  final TrackInfo info;

  /// Extra information about this track provided by plugins.
  final Map<String, Object?> pluginInfo;

  /// Create a new [Track].
  Track({required this.encoded, required this.info, required this.pluginInfo});

  factory Track.fromJson(Map<String, Object?> json) => _$TrackFromJson(json);
}

/// Information about a [Track].
@JsonSerializable()
class TrackInfo {
  /// The track's identifier.
  final String identifier;

  /// Whether the track is seekable.
  final bool isSeekable;

  /// The track's author.
  final String author;

  /// The length of the track.
  @JsonKey(fromJson: _durationFromMilliseconds)
  final Duration length;

  /// Whether the track is a stream.
  final bool isStream;

  /// The track's current playback position.
  @JsonKey(fromJson: _durationFromMilliseconds)
  final Duration position;

  /// The track's title.
  final String title;

  /// The track's URI.
  final Uri? uri;

  /// A URL to the track's artwork or cover image.
  final Uri? artworkUrl;

  /// The track's ISRC.
  final String? isrc;

  /// The name of the source providing the track.
  final String sourceName;

  /// Create a new [TrackInfo].
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

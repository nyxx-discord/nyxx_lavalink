import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/messages/events/track_exception.dart';
import 'package:lavalink/src/models/track.dart';

part 'loaded_track_result.g.dart';

/// The result of loading a track, playlist or search.
sealed class LoadResult {
  /// The type of result.
  final String loadType;

  /// The data associated with the result.
  dynamic get data;

  /// Create a new [LoadResult].
  LoadResult({required this.loadType});

  factory LoadResult.fromJson(Map<String, Object?> json) {
    return switch (json['loadType']) {
      'track' => TrackLoadResult.fromJson(json),
      'playlist' => PlaylistLoadResult.fromJson(json),
      'search' => SearchLoadResult.fromJson(json),
      'empty' => EmptyLoadResult.fromJson(json),
      'error' => ErrorLoadResult.fromJson(json),
      _ => throw FormatException('Unknown loadType', json['loadType']),
    };
  }
}

/// The [LoadResult] for a single track.
@JsonSerializable()
class TrackLoadResult extends LoadResult {
  @override
  final Track data;

  /// Create a new [TrackLoadResult].
  TrackLoadResult({required super.loadType, required this.data});

  factory TrackLoadResult.fromJson(Map<String, Object?> json) => _$TrackLoadResultFromJson(json);
}

/// The [LoadResult] for a playlist.
@JsonSerializable()
class PlaylistLoadResult extends LoadResult {
  @override
  final Playlist data;

  /// Create a new [PlaylistLoadResult].
  PlaylistLoadResult({required super.loadType, required this.data});

  factory PlaylistLoadResult.fromJson(Map<String, Object?> json) => _$PlaylistLoadResultFromJson(json);
}

/// A playlist of tracks.
@JsonSerializable()
class Playlist {
  /// Information about this playlist.
  final PlaylistInfo info;

  /// Additional info provided by plugins.
  final Map<String, Object?> pluginInfo;

  /// The tracks in this playlist.
  final List<Track> tracks;

  /// Create a new [Playlist].
  Playlist({required this.info, required this.pluginInfo, required this.tracks});

  factory Playlist.fromJson(Map<String, Object?> json) => _$PlaylistFromJson(json);
}

/// Information about a playlist.
@JsonSerializable()
class PlaylistInfo {
  /// The name of the playlist.
  final String name;

  /// The currently selected track.
  final int selectedTrack;

  /// Create a ne w[PlaylistInfo].
  PlaylistInfo({required this.name, required this.selectedTrack});

  factory PlaylistInfo.fromJson(Map<String, Object?> json) => _$PlaylistInfoFromJson(json);
}

/// The [LoadResult] for a search.
@JsonSerializable()
class SearchLoadResult extends LoadResult {
  @override
  final List<Track> data;

  /// Create a new [SearchLoadResult].
  SearchLoadResult({required super.loadType, required this.data});

  factory SearchLoadResult.fromJson(Map<String, Object?> json) => _$SearchLoadResultFromJson(json);
}

/// An empty [LoadResult].
@JsonSerializable()
class EmptyLoadResult extends LoadResult {
  @override
  void get data {}

  /// Create a new [EmptyLoadResult].
  EmptyLoadResult({required super.loadType});

  factory EmptyLoadResult.fromJson(Map<String, Object?> json) => _$EmptyLoadResultFromJson(json);
}

/// The [LoadResult] returned when an error occurred while loading.
@JsonSerializable()
class ErrorLoadResult extends LoadResult {
  @override
  final ExceptionInfo data;

  /// Create a new [ErrorLoadResult].
  ErrorLoadResult({required super.loadType, required this.data});

  factory ErrorLoadResult.fromJson(Map<String, Object?> json) => _$ErrorLoadResultFromJson(json);
}

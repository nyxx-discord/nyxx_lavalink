import 'package:json_annotation/json_annotation.dart';
import 'package:lavalink/src/messages/events/track_exception.dart';
import 'package:lavalink/src/models/track.dart';

part 'loaded_track_result.g.dart';

sealed class LoadResult {
  final String loadType;

  dynamic get data;

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

@JsonSerializable()
class TrackLoadResult extends LoadResult {
  @override
  final Track data;

  TrackLoadResult({required super.loadType, required this.data});

  factory TrackLoadResult.fromJson(Map<String, Object?> json) => _$TrackLoadResultFromJson(json);
}

@JsonSerializable()
class PlaylistLoadResult extends LoadResult {
  @override
  final Playlist data;

  PlaylistLoadResult({required super.loadType, required this.data});

  factory PlaylistLoadResult.fromJson(Map<String, Object?> json) =>
      _$PlaylistLoadResultFromJson(json);
}

@JsonSerializable()
class Playlist {
  final PlaylistInfo info;
  final Map<String, Object?> pluginInfo;
  final List<Track> tracks;

  Playlist({required this.info, required this.pluginInfo, required this.tracks});

  factory Playlist.fromJson(Map<String, Object?> json) => _$PlaylistFromJson(json);
}

@JsonSerializable()
class PlaylistInfo {
  final String name;
  final int selectedTrack;

  PlaylistInfo({required this.name, required this.selectedTrack});

  factory PlaylistInfo.fromJson(Map<String, Object?> json) => _$PlaylistInfoFromJson(json);
}

@JsonSerializable()
class SearchLoadResult extends LoadResult {
  @override
  final List<Track> data;

  SearchLoadResult({required super.loadType, required this.data});

  factory SearchLoadResult.fromJson(Map<String, Object?> json) => _$SearchLoadResultFromJson(json);
}

@JsonSerializable()
class EmptyLoadResult extends LoadResult {
  @override
  void get data {}

  EmptyLoadResult({required super.loadType});

  factory EmptyLoadResult.fromJson(Map<String, Object?> json) => _$EmptyLoadResultFromJson(json);
}

@JsonSerializable()
class ErrorLoadResult extends LoadResult {
  @override
  final ExceptionInfo data;

  ErrorLoadResult({required super.loadType, required this.data});

  factory ErrorLoadResult.fromJson(Map<String, Object?> json) => _$ErrorLoadResultFromJson(json);
}

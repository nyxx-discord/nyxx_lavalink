// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaded_track_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackLoadResult _$TrackLoadResultFromJson(Map<String, dynamic> json) => TrackLoadResult(
      loadType: json['loadType'] as String,
      data: Track.fromJson(json['data'] as Map<String, dynamic>),
    );

PlaylistLoadResult _$PlaylistLoadResultFromJson(Map<String, dynamic> json) => PlaylistLoadResult(
      loadType: json['loadType'] as String,
      data: Playlist.fromJson(json['data'] as Map<String, dynamic>),
    );

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      info: PlaylistInfo.fromJson(json['info'] as Map<String, dynamic>),
      pluginInfo: json['pluginInfo'] as Map<String, dynamic>,
      tracks: (json['tracks'] as List<dynamic>).map((e) => Track.fromJson(e as Map<String, dynamic>)).toList(),
    );

PlaylistInfo _$PlaylistInfoFromJson(Map<String, dynamic> json) => PlaylistInfo(
      name: json['name'] as String,
      selectedTrack: json['selectedTrack'] as int,
    );

SearchLoadResult _$SearchLoadResultFromJson(Map<String, dynamic> json) => SearchLoadResult(
      loadType: json['loadType'] as String,
      data: (json['data'] as List<dynamic>).map((e) => Track.fromJson(e as Map<String, dynamic>)).toList(),
    );

EmptyLoadResult _$EmptyLoadResultFromJson(Map<String, dynamic> json) => EmptyLoadResult(
      loadType: json['loadType'] as String,
    );

ErrorLoadResult _$ErrorLoadResultFromJson(Map<String, dynamic> json) => ErrorLoadResult(
      loadType: json['loadType'] as String,
      data: ExceptionInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

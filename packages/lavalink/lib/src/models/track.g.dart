// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      encoded: json['encoded'] as String,
      info: TrackInfo.fromJson(json['info'] as Map<String, dynamic>),
      pluginInfo: json['pluginInfo'] as Map<String, dynamic>,
    );

TrackInfo _$TrackInfoFromJson(Map<String, dynamic> json) => TrackInfo(
      identifier: json['identifier'] as String,
      isSeekable: json['isSeekable'] as bool,
      author: json['author'] as String,
      length: durationFromMilliseconds((json['length'] as num).toInt()),
      isStream: json['isStream'] as bool,
      position: durationFromMilliseconds((json['position'] as num).toInt()),
      title: json['title'] as String,
      uri: json['uri'] == null ? null : Uri.parse(json['uri'] as String),
      artworkUrl: json['artworkUrl'] == null ? null : Uri.parse(json['artworkUrl'] as String),
      isrc: json['isrc'] as String?,
      sourceName: json['sourceName'] as String,
    );

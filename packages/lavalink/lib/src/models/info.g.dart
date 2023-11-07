// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LavalinkInfo _$LavalinkInfoFromJson(Map<String, dynamic> json) => LavalinkInfo(
      version: Version.fromJson(json['version'] as Map<String, dynamic>),
      buildTime: _dateTimeFromMilliseconds(json['buildTime'] as int),
      git: Git.fromJson(json['git'] as Map<String, dynamic>),
      jvm: json['jvm'] as String,
      lavaplayer: json['lavaplayer'] as String,
      sourceManagers: (json['sourceManagers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      filters:
          (json['filters'] as List<dynamic>).map((e) => e as String).toList(),
      plugins: (json['plugins'] as List<dynamic>)
          .map((e) => Plugin.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Version _$VersionFromJson(Map<String, dynamic> json) => Version(
      semver: json['semver'] as String,
      major: json['major'] as int,
      minor: json['minor'] as int,
      patch: json['patch'] as int,
      preRelease: json['preRelease'] as String?,
      build: json['build'] as String?,
    );

Git _$GitFromJson(Map<String, dynamic> json) => Git(
      branch: json['branch'] as String,
      commit: json['commit'] as String,
      commitTime: _dateTimeFromMilliseconds(json['commitTime'] as int),
    );

Plugin _$PluginFromJson(Map<String, dynamic> json) => Plugin(
      name: json['name'] as String,
      version: json['version'] as String,
    );

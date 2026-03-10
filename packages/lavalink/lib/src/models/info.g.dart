// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LavalinkInfo _$LavalinkInfoFromJson(Map<String, dynamic> json) => LavalinkInfo(
  version: Version.fromJson(json['version'] as Map<String, dynamic>),
  buildTime: _dateTimeFromMilliseconds((json['buildTime'] as num).toInt()),
  git: Git.fromJson(json['git'] as Map<String, dynamic>),
  jvm: json['jvm'] as String,
  lavaplayer: json['lavaplayer'] as String,
  sourceManagers: (json['sourceManagers'] as List<dynamic>).map((e) => e as String).toList(),
  filters: (json['filters'] as List<dynamic>).map((e) => e as String).toList(),
  plugins: (json['plugins'] as List<dynamic>).map((e) => Plugin.fromJson(e as Map<String, dynamic>)).toList(),
);

Version _$VersionFromJson(Map<String, dynamic> json) => Version(
  semver: json['semver'] as String,
  major: (json['major'] as num).toInt(),
  minor: (json['minor'] as num).toInt(),
  patch: (json['patch'] as num).toInt(),
  preRelease: json['preRelease'] as String?,
  build: json['build'] as String?,
);

Git _$GitFromJson(Map<String, dynamic> json) =>
    Git(branch: json['branch'] as String, commit: json['commit'] as String, commitTime: _dateTimeFromMilliseconds((json['commitTime'] as num).toInt()));

Plugin _$PluginFromJson(Map<String, dynamic> json) => Plugin(name: json['name'] as String, version: json['version'] as String);

import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

DateTime _dateTimeFromMilliseconds(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);

@JsonSerializable()
class LavalinkInfo {
  final Version version;
  @JsonKey(fromJson: _dateTimeFromMilliseconds)
  DateTime buildTime;
  final Git git;
  final String jvm;
  final String lavaplayer;
  final List<String> sourceManagers;
  final List<String> filters;
  final List<Plugin> plugins;

  LavalinkInfo({
    required this.version,
    required this.buildTime,
    required this.git,
    required this.jvm,
    required this.lavaplayer,
    required this.sourceManagers,
    required this.filters,
    required this.plugins,
  });

  factory LavalinkInfo.fromJson(Map<String, Object?> json) => _$LavalinkInfoFromJson(json);
}

@JsonSerializable()
class Version {
  final String semver;
  final int major;
  final int minor;
  final int patch;
  final String? preRelease;
  final String? build;

  Version({
    required this.semver,
    required this.major,
    required this.minor,
    required this.patch,
    required this.preRelease,
    required this.build,
  });

  factory Version.fromJson(Map<String, Object?> json) => _$VersionFromJson(json);
}

@JsonSerializable()
class Git {
  final String branch;
  final String commit;
  @JsonKey(fromJson: _dateTimeFromMilliseconds)
  final DateTime commitTime;

  Git({required this.branch, required this.commit, required this.commitTime});

  factory Git.fromJson(Map<String, Object?> json) => _$GitFromJson(json);
}

@JsonSerializable()
class Plugin {
  final String name;
  final String version;

  Plugin({required this.name, required this.version});

  factory Plugin.fromJson(Map<String, Object?> json) => _$PluginFromJson(json);
}

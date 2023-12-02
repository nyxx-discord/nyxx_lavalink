import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

DateTime _dateTimeFromMilliseconds(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);

/// Information about a Lavalink server.
@JsonSerializable()
class LavalinkInfo {
  /// The version of ths server.
  final Version version;

  /// The time at which the server was built.
  @JsonKey(fromJson: _dateTimeFromMilliseconds)
  final DateTime buildTime;

  /// Information about the git revision the server is running.
  final Git git;

  /// The version of the JVM used to run the server.
  final String jvm;

  /// The version of lavaplayer being used.
  final String lavaplayer;

  /// A list of available source managers.
  final List<String> sourceManagers;

  /// A list of available filters.
  final List<String> filters;

  /// A list of plugins the server is using.
  final List<Plugin> plugins;

  /// Create a new [LavalinkInfo].
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

/// Information about a Lavalink version.
@JsonSerializable()
class Version {
  /// The version expressed as a semantic versioning string.
  final String semver;

  /// The major version.
  final int major;

  /// The minor version.
  final int minor;

  /// The patch version.
  final int patch;

  /// The pre-release information.
  final String? preRelease;

  /// The build information.
  final String? build;

  /// Create a new [Version].
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

/// Information about a Git revision.
@JsonSerializable()
class Git {
  /// The branch the revision is on.
  final String branch;

  /// The commit hash.
  final String commit;

  /// The time at which the commit was made.
  @JsonKey(fromJson: _dateTimeFromMilliseconds)
  final DateTime commitTime;

  /// Create a new [Git].
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

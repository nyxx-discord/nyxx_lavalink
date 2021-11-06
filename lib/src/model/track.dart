import 'package:nyxx/nyxx.dart';

import 'package:nyxx_lavalink/src/model/exception.dart';

abstract class IQueuedTrack {
  /// The actual track
  ITrack get track;

  /// Where should start lavalink playing the track
  Duration get startTime;

  /// If the track should stop playing before finish and where
  Duration? get endTime;

  /// The requester of the track
  Snowflake? get requester;

  /// The channel where this track was requested
  Snowflake? get channelId;
}

/// Represents a track already on a player queue
class QueuedTrack implements IQueuedTrack {
  /// The actual track
  @override
  final ITrack track;

  /// Where should start lavalink playing the track
  @override
  final Duration startTime;

  /// If the track should stop playing before finish and where
  @override
  final Duration? endTime;

  /// The requester of the track
  @override
  final Snowflake? requester;

  /// The channel where this track was requested
  @override
  final Snowflake? channelId;

  /// Create a new QueuedTrack instance
  QueuedTrack(this.track, this.startTime, this.endTime, this.requester, this.channelId);
}

abstract class ITrack {
  /// Base64 encoded track
  String get track;

  /// Optional information about the track
  ITrackInfo? get info;
}

/// Lavalink track object
class Track implements ITrack {
  /// Base64 encoded track
  @override
  late final String track;

  /// Optional information about the track
  @override
  late final ITrackInfo? info;

  /// Create a new track instance
  Track(this.track, this.info);

  Track.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("info")) {
      info = TrackInfo(json["info"] as Map<String, dynamic>);
    }

    track = json["track"] as String;
  }
}

abstract class ITrackInfo {
  /// Track identifier
  String get identifier;

  /// If the track is seekable (if it's a streaming it's not)
  bool get seekable;

  /// The author of the track
  String get author;

  /// The length of the track
  int get length;

  /// Whether the track is a streaming or not
  bool get stream;

  /// Position returned by lavalink
  int get position;

  /// The title of the track
  String get title;

  /// Url of the track
  String get uri;
}

/// Track details
class TrackInfo implements ITrackInfo {
  /// Track identifier
  @override
  late final String identifier;

  /// If the track is seekable (if it's a streaming it's not)
  @override
  late final bool seekable;

  /// The author of the track
  @override
  late final String author;

  /// The length of the track
  @override
  late final int length;

  /// Whether the track is a streaming or not
  @override
  late final bool stream;

  /// Position returned by lavalink
  @override
  late final int position;

  /// The title of the track
  @override
  late final String title;

  /// Url of the track
  @override
  late final String uri;

  TrackInfo(Map<String, dynamic> json) {
    identifier = json["identifier"] as String;
    seekable = json["isSeekable"] as bool;
    author = json["author"] as String;
    length = json["length"] as int;
    stream = json["isStream"] as bool;
    position = json["position"] as int;
    title = json["title"] as String;
    uri = json["uri"] as String;
  }
}

abstract class IPlaylistInfo {
  /// Name of the playlist
  String? get name;

  /// Currently selected track
  int? get selectedTrack;
}

/// Playlist info
class PlaylistInfo implements IPlaylistInfo {
  /// Name of the playlist
  @override
  late final String? name;

  /// Currently selected track
  @override
  late final int? selectedTrack;

  PlaylistInfo(Map<String, dynamic> json) {
    name = json["name"] as String?;
    selectedTrack = json["selectedTrack"] as int?;
  }
}

abstract class ITracks {
  /// Information about loaded playlist
  IPlaylistInfo get playlistInfo;

  /// Load type (track, playlist, etc)
  String get loadType;

  /// Loaded tracks
  List<ITrack> get tracks;

  /// Occurred exception (if occurred)
  ILavalinkException? get exception;
}

/// Object returned from lavalink when searching
class Tracks implements ITracks {
  /// Information about loaded playlist
  @override
  late final IPlaylistInfo playlistInfo;

  /// Load type (track, playlist, etc)
  @override
  late final String loadType;

  /// Loaded tracks
  @override
  late final List<ITrack> tracks;

  /// Occurred exception (if occurred)
  @override
  late final ILavalinkException? exception;

  Tracks(Map<String, dynamic> json) {
    playlistInfo = PlaylistInfo(json["playlistInfo"] as Map<String, dynamic>);
    loadType = json["loadType"] as String;
    tracks = (json["tracks"] as List<dynamic>).map((t) => Track.fromJson(t as Map<String, dynamic>)).toList();
    exception = json["exception"] == null ? null : LavalinkException(json["exception"] as Map<String, dynamic>);
  }
}

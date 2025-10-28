import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';

/// An abstract class representing a plugin.
abstract class LavalinkExternalPlugin {
  /// The name of this plugin.
  String get name;

  /// A list of all handled events by this plugins.
  ///
  /// I.e
  /// ```dart
  /// class SponsorblockPlugin implements LavalinkExternalPlugin {
  ///   @override
  ///   late final Map<String, LavalinkEvent Function(Map<String, Object?>)> handledEvents = {
  ///     'SegmentsLoaded': SegmentsLoaded.fromJson,
  ///     'SegmentSkipped': SegmentsSkipped.fromJson,
  ///     'ChaptersLoad': ChaptersLoad.fromJson,
  ///     'ChapterStarted': ChaptersStarted.fromJson,
  ///   };
  /// }
  /// ```
  Map<String, LavalinkEvent Function(Map<String, Object?>)> get handledEvents;

  /// A reference to this client.
  final LavalinkClient client;

  const LavalinkExternalPlugin(this.client);
}

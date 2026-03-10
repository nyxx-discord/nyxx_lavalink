import 'package:lavalink/src/client.dart';
import 'package:lavalink/src/messages/event.dart';

/// A handler for an external plugin event.
///
/// You might also be interested in:
///  - [LavalinkExternalPlugin] which represents a plugin.
///  - [LavalinkEvent] which represents an event received by lavalink.
typedef LavalinkExternalPluginEventHandler = LavalinkEvent Function(Map<String, Object?>);

/// An abstract class representing a plugin.
/// A plugin can handle multiple events and provide additional functionality to the [LavalinkClient].
///
/// You might also be interested in:
/// - [LavalinkExternalPluginEventHandler] which represents a handler for an external plugin event.
/// - [LavalinkClient] which represents a client connected to a lavalink server.
abstract class LavalinkExternalPlugin {
  /// The name of this plugin.
  String get name;

  /// A list of all handled events by this plugins.
  ///
  /// I.e
  /// ```dart
  /// class SponsorblockPlugin implements LavalinkExternalPlugin {
  ///   @override
  ///   final Map<String, LavalinkExternalPluginEventHandler> handledEvents = {
  ///     'SegmentsLoaded': SegmentsLoaded.fromJson,
  ///     'SegmentSkipped': SegmentsSkipped.fromJson,
  ///     'ChaptersLoad': ChaptersLoad.fromJson,
  ///     'ChapterStarted': ChaptersStarted.fromJson,
  ///   };
  /// }
  /// ```
  Map<String, LavalinkExternalPluginEventHandler> get handledEvents;

  /// A reference to this client.
  final LavalinkClient client;

  /// @nodoc
  const LavalinkExternalPlugin(this.client);
}

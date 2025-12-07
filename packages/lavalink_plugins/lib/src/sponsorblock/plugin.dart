import 'dart:convert';

import 'package:lavalink/lavalink.dart';
import 'package:lavalink_plugins/src/sponsorblock/models/events/chapter_started.dart';
import 'package:lavalink_plugins/src/sponsorblock/models/events/chapters_loaded.dart';
import 'package:lavalink_plugins/src/sponsorblock/models/events/segment_skipped.dart';
import 'package:lavalink_plugins/src/sponsorblock/models/events/segments_loaded.dart';
import 'package:lavalink_plugins/src/sponsorblock/models/segment_category.dart';

/// A plugin for the [SponsorBlock](https://github.com/topi314/Sponsorblock-Plugin) lavalink plugin.
class SponsorblockPlugin extends LavalinkExternalPlugin {
  @override
  String get name => "sponsorblock";

  @override
  final Map<String, LavalinkExternalPluginEventHandler> handledEvents = {
    'SegmentsLoaded': SegmentsLoaded.fromJson,
    'SegmentSkipped': SegmentSkipped.fromJson,
    'ChaptersLoaded': ChaptersLoaded.fromJson,
    'ChapterStarted': ChapterStarted.fromJson,
  };

  SponsorblockPlugin(super.client);

  /// Get all the categories this session has.
  Future<List<SegmentCategory>> getCategories(String guildId) async {
    final response = jsonDecode(await client.executeSafe('GET', '/v4/sessions/${client.connection.sessionId}/players/$guildId/sponsorblock/categories'));
    return (response as List).map((r) => SegmentCategory.values.firstWhere((c) => c.category == r)).toList();
  }

  Future<void> putCategories(String guildId, List<SegmentCategory> categories) async {
    await client.executeSafe(
      'PUT',
      '/v4/sessions/${client.connection.sessionId}/players/$guildId/sponsorblock/categories',
      body: categories.map((c) => c.category).toList(),
    );
  }

  Future<void> deleteCategories(String guildId) async {
    await client.executeSafe('DELETE', '/v4/sessions/${client.connection.sessionId}/players/$guildId/sponsorblock/categories');
  }
}

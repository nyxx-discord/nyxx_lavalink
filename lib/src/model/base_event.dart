import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/src/node/node.dart';

abstract class IBaseEvent {
  /// A reference to the current client
  INyxx get client;

  /// A reference to the node this event belongs to
  INode get node;
}

/// Base event class which all events must inherit
class BaseEvent implements IBaseEvent {
  /// A reference to the current client
  @override
  final INyxx client;

  /// A reference to the node this event belongs to
  @override
  final INode node;

  /// Creates a new base event instance
  BaseEvent(this.client, this.node);
}

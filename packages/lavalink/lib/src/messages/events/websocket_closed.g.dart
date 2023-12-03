// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_closed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketClosedEvent _$WebSocketClosedEventFromJson(
        Map<String, dynamic> json) =>
    WebSocketClosedEvent(
      client: identity(json['client'] as LavalinkClient),
      opType: json['op'] as String,
      type: json['type'] as String,
      guildId: json['guildId'] as String,
      code: json['code'] as int,
      reason: json['reason'] as String,
      wasByRemote: json['wasByRemote'] as bool?,
    );

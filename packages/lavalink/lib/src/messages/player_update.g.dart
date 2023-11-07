// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerUpdateMessage _$PlayerUpdateMessageFromJson(Map<String, dynamic> json) =>
    PlayerUpdateMessage(
      client: identity(json['client'] as LavalinkClient),
      opType: json['op'] as String,
      guildId: json['guildId'] as String,
      state: PlayerState.fromJson(json['state'] as Map<String, dynamic>),
    );

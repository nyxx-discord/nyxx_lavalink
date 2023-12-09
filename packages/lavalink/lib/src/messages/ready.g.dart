// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ready.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LavalinkReadyMessage _$LavalinkReadyMessageFromJson(Map<String, dynamic> json) => LavalinkReadyMessage(
      client: identity(json['client'] as LavalinkClient),
      opType: json['op'] as String,
      wasResumed: json['resumed'] as bool,
      sessionId: json['sessionId'] as String,
    );

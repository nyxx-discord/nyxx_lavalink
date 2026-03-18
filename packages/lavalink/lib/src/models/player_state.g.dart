// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerState _$PlayerStateFromJson(Map<String, dynamic> json) => PlayerState(
  time: dateTimeFromMilliseconds((json['time'] as num).toInt()),
  position: durationFromMilliseconds((json['position'] as num).toInt()),
  isConnected: json['connected'] as bool,
  ping: durationFromMilliseconds((json['ping'] as num).toInt()),
);

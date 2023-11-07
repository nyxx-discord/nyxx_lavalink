// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerState _$PlayerStateFromJson(Map<String, dynamic> json) => PlayerState(
      time: _dateTimeFromMilliseconds(json['time'] as int),
      position: _durationFromMilliseconds(json['position'] as int),
      isConnected: json['connected'] as bool,
      ping: _durationFromMilliseconds(json['ping'] as int),
    );

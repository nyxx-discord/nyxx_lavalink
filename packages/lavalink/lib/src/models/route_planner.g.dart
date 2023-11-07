// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_planner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePlannerStatus _$RoutePlannerStatusFromJson(Map<String, dynamic> json) =>
    RoutePlannerStatus(
      type: json['type'] as String?,
      details: json['details'] == null
          ? null
          : RoutePlannerDetails.fromJson(
              json['details'] as Map<String, dynamic>),
    );

RoutePlannerDetails _$RoutePlannerDetailsFromJson(Map<String, dynamic> json) =>
    RoutePlannerDetails(
      ipBlock: IpBlock.fromJson(json['ipBlock'] as Map<String, dynamic>),
      failingAddresses: (json['failingAddresses'] as List<dynamic>)
          .map((e) => FailingAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      rotateIndex: json['rotateIndex'] as String?,
      ipIndex: json['ipIndex'] as String?,
      currentAddress: json['currentAddress'] as String?,
      currentAddressIndex: json['currentAddressIndex'] as String?,
      blockIndex: json['blockIndex'] as String?,
    );

IpBlock _$IpBlockFromJson(Map<String, dynamic> json) => IpBlock(
      type: json['type'] as String,
      size: json['size'] as String,
    );

FailingAddress _$FailingAddressFromJson(Map<String, dynamic> json) =>
    FailingAddress(
      failingAddress: json['failingAddress'] as String,
      failingTimestamp:
          _dateTimeFromMilliseconds(json['failingTimestamp'] as int),
      failingTime: json['failingTime'] as String,
    );

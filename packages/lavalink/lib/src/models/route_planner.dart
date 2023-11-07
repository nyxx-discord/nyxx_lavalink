import 'package:json_annotation/json_annotation.dart';

part 'route_planner.g.dart';

DateTime _dateTimeFromMilliseconds(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);

@JsonSerializable()
class RoutePlannerStatus {
  final String? type;
  final RoutePlannerDetails? details;

  RoutePlannerStatus({required this.type, required this.details});

  factory RoutePlannerStatus.fromJson(Map<String, Object?> json) =>
      _$RoutePlannerStatusFromJson(json);
}

@JsonSerializable()
class RoutePlannerDetails {
  final IpBlock ipBlock;
  final List<FailingAddress> failingAddresses;
  final String? rotateIndex;
  final String? ipIndex;
  final String? currentAddress;
  final String? currentAddressIndex;
  final String? blockIndex;

  RoutePlannerDetails({
    required this.ipBlock,
    required this.failingAddresses,
    required this.rotateIndex,
    required this.ipIndex,
    required this.currentAddress,
    required this.currentAddressIndex,
    required this.blockIndex,
  });

  factory RoutePlannerDetails.fromJson(Map<String, Object?> json) =>
      _$RoutePlannerDetailsFromJson(json);
}

@JsonSerializable()
class IpBlock {
  final String type;
  final String size;

  IpBlock({required this.type, required this.size});

  factory IpBlock.fromJson(Map<String, Object?> json) => _$IpBlockFromJson(json);
}

@JsonSerializable()
class FailingAddress {
  final String failingAddress;
  @JsonKey(fromJson: _dateTimeFromMilliseconds)
  final DateTime failingTimestamp;
  final String failingTime;

  FailingAddress({
    required this.failingAddress,
    required this.failingTimestamp,
    required this.failingTime,
  });

  factory FailingAddress.fromJson(Map<String, Object?> json) => _$FailingAddressFromJson(json);
}

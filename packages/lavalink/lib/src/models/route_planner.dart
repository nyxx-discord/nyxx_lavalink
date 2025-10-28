import 'package:json_annotation/json_annotation.dart';

part 'route_planner.g.dart';

DateTime _dateTimeFromMilliseconds(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);

/// Status about the RoutePlanner extension on a Lavalink server.
@JsonSerializable()
class RoutePlannerStatus {
  /// The current type of RoutePlanner.
  final String? type;

  /// Information about the current RoutePlanner configuration.
  final RoutePlannerDetails? details;

  /// Create a new [RoutePlannerStatus].
  RoutePlannerStatus({required this.type, required this.details});

  factory RoutePlannerStatus.fromJson(Map<String, Object?> json) => _$RoutePlannerStatusFromJson(json);
}

/// Information about the configuration of the RoutePlanner extension on a Lavalink server.
@JsonSerializable()
class RoutePlannerDetails {
  /// The IP block usable by the server.
  final IpBlock ipBlock;

  /// The currently failing IP addresses.
  final List<FailingAddress> failingAddresses;

  /// The number of rotations.
  final String? rotateIndex;

  /// The current offset in the block.
  final String? ipIndex;

  /// The current address being used.
  final String? currentAddress;

  /// The current offset in the ip block.
  final String? currentAddressIndex;

  /// The information in which /64 block ips are chosen.
  ///
  /// This number increases on each ban.
  final String? blockIndex;

  /// Create a new [RoutePlannerDetails].
  RoutePlannerDetails({
    required this.ipBlock,
    required this.failingAddresses,
    required this.rotateIndex,
    required this.ipIndex,
    required this.currentAddress,
    required this.currentAddressIndex,
    required this.blockIndex,
  });

  factory RoutePlannerDetails.fromJson(Map<String, Object?> json) => _$RoutePlannerDetailsFromJson(json);
}

/// A block of IP addresses.
@JsonSerializable()
class IpBlock {
  /// The type of this block.
  final String type;

  /// THe size of this block.
  final String size;

  /// Create a new [IpBlock].
  IpBlock({required this.type, required this.size});

  factory IpBlock.fromJson(Map<String, Object?> json) => _$IpBlockFromJson(json);
}

/// Information about an IP address determined to be failing.
@JsonSerializable()
class FailingAddress {
  /// The IP address.
  final String failingAddress;

  /// The time at which the address failed.
  @JsonKey(fromJson: _dateTimeFromMilliseconds)
  final DateTime failingTimestamp;

  /// A human-readable string containing the time at which the address failed.
  final String failingTime;

  FailingAddress({
    required this.failingAddress,
    required this.failingTimestamp,
    required this.failingTime,
  });

  factory FailingAddress.fromJson(Map<String, Object?> json) => _$FailingAddressFromJson(json);
}

import 'package:equatable/equatable.dart';

import '../../feature/parking_spot/domain/entities/location.dart';

class ParkingPlace extends Equatable {
  ParkingPlace({
    this.businessStatus,
    this.location,
    this.icon,
    this.name,
    this.placeId,
    this.rating,
    this.userRatingsTotal,
    this.vicinity,
  });

  final String businessStatus;
  final Location location;
  final String icon;
  final String name;
  final String placeId;
  final num rating;
  final int userRatingsTotal;
  final String vicinity;

  @override
  List<Object> get props => [placeId, location];
}

import '../../feature/parking_spot/domain/entities/location.dart';

class ParkingPlace {
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

  String businessStatus;
  Location location;
  String icon;
  String name;
  String placeId;
  num rating;
  int userRatingsTotal;
  String vicinity;
}

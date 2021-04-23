import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/parking_place.dart';

import 'location_model.dart';

class ParkingPlaceModel extends ParkingPlace {
  ParkingPlaceModel({
    String businessStatus,
    Location location,
    String icon,
    String name,
    String placeId,
    num rating,
    int userRatingsTotal,
    String vicinity,
  }) : super(
            businessStatus: businessStatus,
            location: location,
            icon: icon,
            name: name,
            placeId: placeId,
            rating: rating,
            userRatingsTotal: userRatingsTotal,
            vicinity: vicinity);

  factory ParkingPlaceModel.fromJson(Map<String, dynamic> json) =>
      ParkingPlaceModel(
        businessStatus:
            json["business_status"] == null ? null : json["business_status"],
        location: LocationModel.fromJson(json["geometry"]["location"]),
        icon: json["icon"] == null ? null : json["icon"],
        name: json["name"] == null ? null : json["name"],
        placeId: json["place_id"] == null ? null : json["place_id"],
        rating: json["rating"] == null ? null : json["rating"],
        userRatingsTotal: json["user_ratings_total"] == null
            ? null
            : json["user_ratings_total"],
        vicinity: json["vicinity"] == null ? null : json["vicinity"],
      );
/*
  Map<String, dynamic> toJson() => {
        "business_status": businessStatus == null ? null : businessStatus,
        "location": location == null ? null : ),
        "icon": icon == null ? null : icon,
        "name": name == null ? null : name,
        "place_id": placeId == null ? null : placeId,
        "rating": rating == null ? null : rating,
        "user_ratings_total":
            userRatingsTotal == null ? null : userRatingsTotal,
        "vicinity": vicinity == null ? null : vicinity,
      };

      */
}

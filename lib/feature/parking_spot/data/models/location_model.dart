import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel(double lat, double lng) : super(lat: lat, lng: lng);

  factory LocationModel.fromJson(Map<String, dynamic> data) {
    return LocationModel(data["lat"], data["lng"]);
  }

  Map<String, double> toJson() => {"lat": lat, "lng": lng};
}

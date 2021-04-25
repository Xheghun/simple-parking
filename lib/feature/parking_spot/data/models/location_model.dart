import '../../domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel(final double lat, final double lng) : super(lat: lat, lng: lng);

  factory LocationModel.fromJson(Map<String, dynamic> data) {
    return LocationModel(data["lat"], data["lng"]);
  }

  Map<String, double> toJson() => {"lat": lat, "lng": lng};
}

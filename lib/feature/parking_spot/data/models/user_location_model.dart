import '../../domain/entities/location.dart';
import 'package:meta/meta.dart';

class LocationModel extends Location {
  LocationModel({@required double lat, @required double lng})
      : super(lat: lat, lng: lng);

  factory LocationModel.parseLocation(Map<String, dynamic> data) {
    return LocationModel(lat: data["lat"], lng: data["lng"]);
  }
}

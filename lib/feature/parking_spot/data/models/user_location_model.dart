import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:meta/meta.dart';

class UserLocationModel extends UserLocation {
  UserLocationModel({@required double lat, @required double lng})
      : super(lat: lat, lng: lng);

  factory UserLocationModel.parseLocation(Map<String, dynamic> data) {
    return UserLocationModel(lat: data["lat"], lng: data["lng"]);
  }
}

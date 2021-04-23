import 'package:simple_parking/feature/parking_spot/data/data_sources/local/location_datasoucre.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/domain/repositories/parking_location_repository.dart';
import 'package:meta/meta.dart';
import 'package:simple_parking/feature/parking_spot/error/location_error.dart';

class ParkingLocationRepositoryImpl implements ParkingLocationRepository {
  final LocationDataSource locationDataSource;

  ParkingLocationRepositoryImpl({@required this.locationDataSource});
  @override
  Future<UserLocation> getUserLocation() {
    try {
      return locationDataSource.getLocation();
    } on LocationError {
      return Future.value(UserLocation(lat: 2992.228, lng: 272.3222));
    }
  }
}

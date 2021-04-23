import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_parking/feature/parking_spot/data/data_sources/local/location_datasoucre.dart';
import 'package:simple_parking/feature/parking_spot/domain/repositories/parking_location_repository.dart';
import 'package:meta/meta.dart';
import 'package:simple_parking/feature/parking_spot/error/location_error.dart';

class ParkingLocationRepositoryImpl implements ParkingLocationRepository {
  final LocationDataSource locationDataSource;

  ParkingLocationRepositoryImpl({@required this.locationDataSource});

  @override
  Future<CameraPosition> getCameraPosition() async {
    CameraPosition cameraPosition;
    try {
      var userLocation = await locationDataSource.getLocation();
      cameraPosition = CameraPosition(
        target: LatLng(userLocation.lat, userLocation.lng),
      );
    } on LocationError {
      cameraPosition = CameraPosition(target: LatLng(2992.228, 272.3222));
    }
    return cameraPosition;
  }
}

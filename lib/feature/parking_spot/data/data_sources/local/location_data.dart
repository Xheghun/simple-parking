import 'package:dartz/dartz.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/error/location_error.dart';

abstract class LocationData {
  ///this will request the  user's location permission
  bool requestPermission();

  ///gets the user location if requestPermission returns true
  ///throws a [LocationError] if permission is denied
  Future<Either<LocationError, UserLocation>> getLocation();
}

class LocationDataImpl implements LocationData {
  @override
  Future<Either<LocationError, UserLocation>> getLocation() {
    // TODO: implement getLocation
    throw UnimplementedError();
  }

  @override
  bool requestPermission() {
  
  }
}

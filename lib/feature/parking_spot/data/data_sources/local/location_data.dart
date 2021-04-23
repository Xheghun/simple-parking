import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/error/location_error.dart';

abstract class LocationData {
  ///checks if the location service is enabled and also
  ///request the  user's location permission
  Future<Either<LocationError, bool>> requestPermission();

  ///gets the user location if requestPermission returns true
  ///throws a [LocationError] if permission is denied
  Future<UserLocation> getLocation();
}

class LocationDataImpl implements LocationData {
  @override
  Future<Either<LocationError, bool>> requestPermission() async {
    LocationError locationError = LocationError(LocationErrorType.NOT_ENABLED,
        message: "location permission denied");

    bool isServiceEnable = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnable) {
      return Left(LocationError(LocationErrorType.NOT_ENABLED,
          message: "location service not enabled"));
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Left(locationError);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Left(locationError);
    }

    return Right(true);
  }

  @override
  Future<UserLocation> getLocation() async {
    Either<LocationError, bool> permissionStatus = await requestPermission();

    permissionStatus.fold((locationError) {
      throw locationError;
    }, (hasPermmission) {
      
    });
  }
}

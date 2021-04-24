import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../domain/entities/location.dart';
import '../../../error/location_error.dart';
import '../../models/user_location_model.dart';

abstract class LocationDataSource {
  ///checks if the location service is enabled and also
  ///request the  user's location permission
  Future<Either<LocationError, bool>> requestPermission();

  ///gets the user location if requestPermission returns true
  ///throws a [LocationError] if permission is denied
  Future<Location> getLocation();
}

class LocationDataSourceImpl implements LocationDataSource {
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
  Future<Location> getLocation() async {
    Either<LocationError, bool> permissionStatus = await requestPermission();

    return permissionStatus.fold((locationError) {
      throw locationError;
    }, (hasPermmission) async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      var parsedPosition = {
        "lat": position.latitude,
        "lng": position.longitude,
      };

      return LocationModel.parseLocation(parsedPosition);
    });
  }
}

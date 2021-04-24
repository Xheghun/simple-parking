import 'package:dartz/dartz.dart';

import '../../../../core/entities/parking_place.dart';
import '../../../../core/failure/failure.dart';
import '../entities/location.dart';

abstract class ParkingLocationData {
  Future<Location> getUserPosition();
  Future<Either<Failure, List<ParkingPlace>>> getNearbyParking(Location location);
}

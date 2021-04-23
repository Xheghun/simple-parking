import 'package:simple_parking/core/failure/failure.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/parking_place.dart';

abstract class ParkingLocationRepository {
  Future<Location> getUserLocation();
  Future<Either<Failure, ParkingPlace>> getNearbyParking(Location location);
}

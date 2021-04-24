import 'package:dartz/dartz.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/core/failure/failure.dart';

abstract class SavedParkingLocalRepository {
  Future<Either<CacheFailure, List<ParkingPlace>>> savedParkingPlaces();
  Future<Either<CacheFailure, void>> savePlace(ParkingPlace place);
}

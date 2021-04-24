import 'package:dartz/dartz.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/core/errors/cache_error.dart';

abstract class SavedParkingLocalRepository {
  Future<Either<CacheError, List<ParkingPlace>>> savedParkingPlaces();
  Future<Either<CacheError,void>> savePlace(ParkingPlace place);
}

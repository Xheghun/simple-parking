import 'package:dartz/dartz.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/core/failure/failure.dart';

abstract class SavedParkingUseCases {
  Future<Either<CacheFailure, bool>> savePlace();
  Future<Either<CacheFailure, List<ParkingPlace>>> savedPlaces();
}
import 'package:dartz/dartz.dart';
import '../../../../core/entities/parking_place.dart';
import '../../../../core/failure/failure.dart';

abstract class SavedParkingLocalRepository {
  Future<Either<CacheFailure, List<ParkingPlace>>> savedParkingPlaces();
  Future<Either<CacheFailure, void>> savePlace(ParkingPlace place);
  Future<Either<CacheFailure,bool>> removePlace(ParkingPlace place);
}

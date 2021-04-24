import 'package:dartz/dartz.dart';

import '../../../../core/entities/parking_place.dart';
import '../../../../core/failure/failure.dart';

abstract class SavedParkingUseCases {
  Future<Either<CacheFailure, bool>> savePlace(ParkingPlace place);
  Future<Either<CacheFailure, List<ParkingPlace>>> savedPlaces();
  Future<Either<CacheFailure, bool>> removePlace(ParkingPlace place);
}

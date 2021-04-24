import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/parking_place.dart';
import '../../../../core/errors/cache_error.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/repositories/saved_parking_repo.dart';
import '../data_sources/local/saved_parking_local_datascource.dart';

class SavedParkingLocalRepositoryImpl implements SavedParkingLocalRepository {
  final SavedParkingLocalDataSource savedParkingLocalDataSource;

  SavedParkingLocalRepositoryImpl({@required this.savedParkingLocalDataSource});

  @override
  Future<Either<CacheFailure, bool>> savePlace(ParkingPlace place) async {
    bool saved = await savedParkingLocalDataSource.savePlace(place);
    if (saved)
      return Right(true);
    else
      return Left(CacheFailure("failed to save"));
  }

  @override
  Future<Either<CacheFailure, List<ParkingPlace>>> savedParkingPlaces() async {
    try {
      return Right(await savedParkingLocalDataSource.savedParkingPlaces());
    } on CacheError {
      return Left(CacheFailure("data not found"));
    }
  }

  @override
  Future<Either<CacheFailure, bool>> removePlace(ParkingPlace place) async {
    bool deleted = await savedParkingLocalDataSource.removePlace(place);
    if (deleted)
      return Right(true);
    else
      return Left(CacheFailure("failed to delete"));
  }
}

import 'package:simple_parking/core/errors/cache_error.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_parking/core/failure/failure.dart';
import 'package:simple_parking/feature/saved_parking/data/data_sources/local/saved_parking_local_datascource.dart';
import 'package:simple_parking/feature/saved_parking/domain/repositories/saved_parking_repo.dart';
import 'package:meta/meta.dart';

class SavedParkingLocalRepositoryImpl implements SavedParkingLocalRepository {
  final SavedParkingLocalDataSource savedParkingLocalDataSource;

  SavedParkingLocalRepositoryImpl({@required this.savedParkingLocalDataSource});

  @override
  Future<Either<CacheFailure, bool>> savePlace(ParkingPlace place) async {
    bool saved = await savedParkingLocalDataSource.savePlace(place);
    if (saved)
      return Right(true);
    else
      return Left(CacheFailure());
  }

  @override
  Future<Either<CacheFailure, List<ParkingPlace>>> savedParkingPlaces() async {
    try {
      return Right(await savedParkingLocalDataSource.savedParkingPlaces());
    } on CacheError {
      return Left(CacheFailure(message: "data not found"));
    }
  }
}

import 'package:simple_parking/core/errors/cache_error.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_parking/feature/saved_parking/data/data_sources/local/saved_parking_local_datascource.dart';
import 'package:simple_parking/feature/saved_parking/domain/repositories/saved_parking_repo.dart';
import 'package:meta/meta.dart';

class SavedParkingLocalRepositoryImpl implements SavedParkingLocalRepository {
  final SavedParkingLocalDataSource savedParkingLocalDataSource;

  SavedParkingLocalRepositoryImpl({@required this.savedParkingLocalDataSource});

  @override
  Future<Either<CacheError, bool>> savePlace(ParkingPlace place) async {
    try {
      return Right(await savedParkingLocalDataSource.savePlace(place));
    } catch (e) {
      return Left(CacheError());
    }
  }

  @override
  Future<Either<CacheError, List<ParkingPlace>>> savedParkingPlaces() {
    // TODO: implement savedParkingPlaces
    throw UnimplementedError();
  }
}

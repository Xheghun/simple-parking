import 'package:dartz/dartz.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/core/failure/failure.dart';
import 'package:simple_parking/feature/saved_parking/domain/repositories/saved_parking_repo.dart';
import 'package:simple_parking/feature/saved_parking/domain/use_case/saved_parking_usecases.dart';
import 'package:meta/meta.dart';

class SavedParkingUseCasesImpl implements SavedParkingUseCases {
  final SavedParkingLocalRepository savedParkingLocalRepository;

  SavedParkingUseCasesImpl({@required this.savedParkingLocalRepository});
  @override
  Future<Either<CacheFailure, bool>> savePlace(ParkingPlace place) =>
      savedParkingLocalRepository.savePlace(place);

  @override
  Future<Either<CacheFailure, List<ParkingPlace>>> savedPlaces() =>
      savedParkingLocalRepository.savedParkingPlaces();
}

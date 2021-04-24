import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/parking_place.dart';
import '../../../../core/failure/failure.dart';
import '../repositories/saved_parking_repo.dart';
import 'saved_parking_usecases.dart';

class SavedParkingUseCasesImpl implements SavedParkingUseCases {
  final SavedParkingLocalRepository savedParkingLocalRepository;

  SavedParkingUseCasesImpl({@required this.savedParkingLocalRepository});
  @override
  Future<Either<CacheFailure, bool>> savePlace(ParkingPlace place) =>
      savedParkingLocalRepository.savePlace(place);

  @override
  Future<Either<CacheFailure, List<ParkingPlace>>> savedPlaces() =>
      savedParkingLocalRepository.savedParkingPlaces();

  @override
  Future<Either<CacheFailure, bool>> removePlace(ParkingPlace place) =>
      savedParkingLocalRepository.removePlace(place);
}

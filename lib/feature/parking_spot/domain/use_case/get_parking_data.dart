import 'package:simple_parking/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/feature/parking_spot/domain/repositories/parking_location_repository.dart';
import 'package:simple_parking/feature/saved_parking/domain/repositories/saved_parking_repo.dart';
import 'package:simple_parking/feature/saved_parking/domain/use_case/saved_parking_usecases_impl.dart';
import 'package:meta/meta.dart';
import 'parking_location_data.dart';

class GetParkingLocationData
    implements ParkingLocationData, SavedParkingUseCasesImpl {
  final ParkingLocationRepository parkingLocationRepository;
  final SavedParkingLocalRepository savedParkingLocalRepository;

  GetParkingLocationData(
      {@required this.parkingLocationRepository,
      @required this.savedParkingLocalRepository});

  @override
  Future<Location> getUserPosition() =>
      parkingLocationRepository.getUserLocation();

  @override
  Future<Either<Failure, List<ParkingPlace>>> getNearbyParking(
          Location location) =>
      parkingLocationRepository.getNearbyParking(location);

  @override
  Future<Either<CacheFailure, bool>> savePlace(ParkingPlace place) =>
      savedParkingLocalRepository.savePlace(place);

  @override
  Future<Either<CacheFailure, List<ParkingPlace>>> savedPlaces() {
    throw UnimplementedError("tried to get saved places outside it's scope");
  }
}

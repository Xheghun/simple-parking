import 'package:simple_parking/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/feature/parking_spot/domain/repositories/parking_location_repository.dart';

import 'parking_location_data.dart';

class GetParkingLocationData implements ParkingLocationData {
  final ParkingLocationRepository parkingLocationRepository;

  GetParkingLocationData(this.parkingLocationRepository);

  @override
  Future<Location> getUserPosition() =>
      parkingLocationRepository.getUserLocation();

  @override
  Future<Either<Failure, List<ParkingPlace>>> getNearbyParking(
          Location location) =>
      parkingLocationRepository.getNearbyParking(location);
}

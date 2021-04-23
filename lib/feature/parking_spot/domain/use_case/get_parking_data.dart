import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/domain/repositories/parking_location_repository.dart';

import 'parking_location_data.dart';

class GetParkingLocationData implements ParkingLocationData {
  final ParkingLocationRepository parkingLocationRepository;

  GetParkingLocationData(this.parkingLocationRepository);

  @override
  Future<UserLocation> getUserPosition() {
    return parkingLocationRepository.getUserLocation();
  }
}

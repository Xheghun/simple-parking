import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';

abstract class ParkingLocationRepository {
  Future<Location> getUserLocation();
}

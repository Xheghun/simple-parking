import 'package:simple_parking/core/entities/parking_place.dart';

abstract class SavedParkingLocalDataSource {
  Future<bool> savePlace(ParkingPlace place);
  Future<List<ParkingPlace>> parkingPlace();
}

class SavedParkingPlaceLocalDataSourceImpl
    implements SavedParkingLocalDataSource {
      
  @override
  Future<List<ParkingPlace>> parkingPlace() {
    // TODO: implement parkingPlace
    throw UnimplementedError();
  }

  @override
  Future<bool> savePlace(ParkingPlace place) {
    // TODO: implement savePlace
    throw UnimplementedError();
  }
}

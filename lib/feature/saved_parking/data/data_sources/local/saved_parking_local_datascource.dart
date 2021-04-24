import 'package:hive/hive.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:meta/meta.dart';

abstract class SavedParkingLocalDataSource {
  Future<void> savePlace(ParkingPlace place);
  Future<List<ParkingPlace>> parkingPlace();
}

class SavedParkingPlaceLocalDataSourceImpl
    implements SavedParkingLocalDataSource {
  final Box box;

  SavedParkingPlaceLocalDataSourceImpl({@required this.box});

  @override
  Future<List<ParkingPlace>> parkingPlace() {
    // TODO: implement parkingPlace
    throw UnimplementedError();
  }

  @override
  Future<void> savePlace(ParkingPlace place) {
   return box.put("parking", place);
  }
}

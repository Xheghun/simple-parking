import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:meta/meta.dart';
import 'package:simple_parking/feature/parking_spot/data/models/parking_place_model.dart';

abstract class SavedParkingLocalDataSource {
  Future<bool> savePlace(ParkingPlace place);
  Future<List<ParkingPlace>> savedParkingPlaces();
}

class SavedParkingPlaceLocalDataSourceImpl
    implements SavedParkingLocalDataSource {
  final SharedPreferences sharedPreferences;

  SavedParkingPlaceLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<ParkingPlace>> savedParkingPlaces() {
    // TODO: implement parkingPlace
    throw UnimplementedError();
  }

  @override
  Future<bool> savePlace(ParkingPlace place) {
    ParkingPlaceModel p = place;
    return sharedPreferences.setString("place", jsonEncode(p.toJson()));
  }
}

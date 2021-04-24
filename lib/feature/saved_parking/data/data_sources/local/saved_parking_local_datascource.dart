import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:meta/meta.dart';
import 'package:simple_parking/core/errors/cache_error.dart';
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
    try {
      List<String> items = sharedPreferences.getStringList("places");

      return Future.value(
          items.map((e) => ParkingPlaceModel.fromJson(jsonDecode(e))).toList());
    } catch (e) {
      throw CacheError();
    }
  }

  @override
  Future<bool> savePlace(ParkingPlace place) {
    var tempPlace = place as ParkingPlaceModel;

    String fPlace = jsonEncode(tempPlace.toJson());

//retrieve current saved items
    List<String> items = sharedPreferences.getStringList("places");

    if (!items.contains(fPlace)) {
      items.add(fPlace);
    }

    return sharedPreferences.setStringList("places", items);
  }
}

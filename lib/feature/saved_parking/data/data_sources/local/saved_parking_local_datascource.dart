import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/entities/parking_place.dart';
import '../../../../../core/errors/cache_error.dart';
import '../../../../parking_spot/data/models/parking_place_model.dart';

abstract class SavedParkingLocalDataSource {
  Future<bool> savePlace(ParkingPlaceModel place);
  Future<List<ParkingPlace>> savedParkingPlaces();
  Future<bool> removePlace(ParkingPlaceModel place);
}

class SavedParkingPlaceLocalDataSourceImpl
    implements SavedParkingLocalDataSource {
  final SharedPreferences sharedPreferences;

  SavedParkingPlaceLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<ParkingPlace>> savedParkingPlaces() async {
    try {
      List<String> items = sharedPreferences.getStringList("places");
      if (items != null)
        return items
            .map((e) => ParkingPlaceModel.fromJson(jsonDecode(e)))
            .toList();
    } catch (e) {
      print(e);
    }
    throw CacheError();
  }

  @override
  Future<bool> savePlace(ParkingPlaceModel place) {
    String fPlace = jsonEncode(place.toJson());
    List<String> items = [];

//retrieve current saved items
    try {
      if (sharedPreferences.getStringList("places").isNotEmpty) {
        items = sharedPreferences.getStringList("places");
      }
    } catch (e) {
      print(e);
    }

    if (!items.contains(fPlace)) {
      items.add(fPlace);
    }

    return sharedPreferences.setStringList("places", items);
  }

  @override
  Future<bool> removePlace(ParkingPlaceModel place) {
    List<String> items = [];
    String fPlace = jsonEncode(place.toJson());

    items = sharedPreferences.getStringList("places");

    if (items.remove(fPlace)) {
      return sharedPreferences.setStringList("places", items);
    }
    return Future.value(false);
  }
}

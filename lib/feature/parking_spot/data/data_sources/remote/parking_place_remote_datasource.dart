import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/parking_place.dart';
import '../../../../../core/errors/server_error.dart';
import '../../../../../keys.dart';
import '../../../domain/entities/location.dart';
import '../../models/parking_place_model.dart';

abstract class ParkingPlaceRemoteDataSource {
  ///get a list of nearby parking from the google places api
  ///throws a [ServerError] if an error occurs
  Future<List<ParkingPlace>> getNearbyParking(Location location);
}

class ParkingPlaceRemoteDataSourceImpl implements ParkingPlaceRemoteDataSource {
  final Dio client;

  ParkingPlaceRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<ParkingPlace>> getNearbyParking(Location location) async {
    String url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

    Map<String, dynamic> queryParam = {
      "rankby": "distance",
      "type": "parking",
      "key": GOOGLE_API_KEY,
      "location": "${location.lat},${location.lng}"
    };

    try {
      final response = await client.get(url, queryParameters: queryParam);

      print("location is: ${location.lat}, ${location.lng}");
      print(response.data["results"]);

      if (response.statusCode == 200) {
        List<ParkingPlace> parkingList = List.from(response.data["results"])
            .map((e) => ParkingPlaceModel.fromJson(e))
            .toList();

        return parkingList;
      }
    } on DioError catch (error) {
      print(error.message);
    }
    throw ServerError();
  }
}

import 'package:dio/dio.dart';
import 'package:simple_parking/feature/parking_spot/data/models/parking_place_model.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/parking_place.dart';
import 'package:simple_parking/feature/parking_spot/error/server_error.dart';
import 'package:meta/meta.dart';
import 'package:simple_parking/keys.dart';

abstract class ParkingPlaceRemoteDataSource {
  //get a list of nearby parking from the google places api
  ///throws a [ServerError] if an error occurs
  Future<ParkingPlace> getNearbyParking(Location location);
}

class ParkingPlaceRemoteDataSourceImpl implements ParkingPlaceRemoteDataSource {
  final Dio client;

  ParkingPlaceRemoteDataSourceImpl({@required this.client});

  @override
  Future<ParkingPlace> getNearbyParking(Location location) async {
    String url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

    Map<String, dynamic> queryParam = {
      "rankby": "distance",
      "type": "parking",
      "key": GOOGLE_API_KEY,
      "location": "${location.lat},${location.lng}"
    };

    try {
      final response = await client.get(url, queryParameters: queryParam);
      if (response.statusCode == 200) {
        return ParkingPlaceModel.fromJson(response.data);
      }
    } on DioError catch (error) {
      print(error.message);
    }
    throw ServerError();
  }
}

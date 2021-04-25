import 'package:dio/dio.dart';
import 'package:simple_parking/core/errors/server_error.dart';
import 'package:simple_parking/feature/parking_spot/data/models/location_model.dart';
import 'package:simple_parking/feature/parking_spot/data/models/suggestion_model.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/suggestion.dart';
import 'package:simple_parking/keys.dart';

abstract class SearchPlaceRemoteDataSource {
  Future<List<Suggestion>> citySuggestions(String input);
  Future<Location> getPlaceLocation(String placeId);
}

class SearPlaceRemoteDataSourceImpl implements SearchPlaceRemoteDataSource {
  final Dio client;

  SearPlaceRemoteDataSourceImpl(this.client);

  @override
  Future<List<Suggestion>> citySuggestions(String input) async {
    var baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    var queryParams = {
      "types": "geocode",
      "key": GOOGLE_API_KEY,
      "input": input
    };

    try {
      var response = await client.get(baseUrl, queryParameters: queryParams);
      print(response.data);
      if (response.statusCode == 200) {
        List<Suggestion> suggestions = List.from(response.data["predictions"])
            .map((e) => SuggestionModel.fromJson(e))
            .toList();

        return suggestions;
      }
    } on DioError catch (error) {
      print(error);
    }
    throw ServerError();
  }

  @override
  Future<Location> getPlaceLocation(String placeId) async {
    String baseUrl = "https://maps.googleapis.com/maps/api/place/details/json";

    var queryParams = {
      "key": GOOGLE_API_KEY,
      "place_id": placeId,
    };

    try {
      var response = await client.get(baseUrl, queryParameters: queryParams);
      print(response.data);
      if (response.statusCode == 200) {
        return LocationModel.fromJson(
            response.data["result"]["geometry"]["location"]);
      }
    } on DioError catch (error) {
      print(error);
    }
    throw ServerError();
  }
}

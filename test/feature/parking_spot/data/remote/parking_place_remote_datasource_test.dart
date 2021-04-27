import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_parking/core/errors/server_error.dart';
import 'package:simple_parking/feature/parking_spot/data/data_sources/remote/parking_place_remote_datasource.dart';
import 'package:simple_parking/feature/parking_spot/data/models/parking_place_model.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/keys.dart';

import '../../../../core/sample/file_helper.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  MockDioClient mockDioClient;

  ParkingPlaceRemoteDataSourceImpl placeRemoteDataSourceImpl;
  setUp(() {
    mockDioClient = MockDioClient();
    placeRemoteDataSourceImpl =
        ParkingPlaceRemoteDataSourceImpl(client: mockDioClient);
  });

  group('get parking locations', () {
    var testParkingPlaceModelList = [
      ParkingPlaceModel.fromJson(readFileAsMap("parking_places_sample.json"))
    ];

    Map<String, dynamic> testQueryParam = {
      "rankby": "distance",
      "type": "parking",
      "key": GOOGLE_API_KEY,
      "location": "${25.197525},${55.274288}"
    };

    test('returns a list of ParkingPlace if successful', () async {
      //arrange
      when(mockDioClient.get(
              "https://maps.googleapis.com/maps/api/place/nearbysearch/json",
              queryParameters: testQueryParam))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(
                  path:
                      "https://maps.googleapis.com/maps/api/place/nearbysearch/json"),
              data: readFileAsMap("sample_parking_server_response.json"),
              statusCode: 200));
//act
      var result = await placeRemoteDataSourceImpl
          .getNearbyParking(Location(lat: 25.197525, lng: 55.274288));

      //assert
      expect(result, equals(testParkingPlaceModelList));
    });

    test('should throw ServerError if response code is anything other than 200',
        () async {
      //arrange
      when(mockDioClient.get(
              "https://maps.googleapis.com/maps/api/place/nearbysearch/json",
              queryParameters: testQueryParam))
          .thenAnswer(
              (_) async => Response(data: {"results": []}, statusCode: 404));
//act
      var result = placeRemoteDataSourceImpl.getNearbyParking;

      //assert
      expect(() => result(Location(lat: 25.197525, lng: 55.274288)),
          throwsA(isInstanceOf<ServerError>()));
    });
  });
}

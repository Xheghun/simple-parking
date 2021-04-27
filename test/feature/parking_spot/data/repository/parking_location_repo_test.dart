import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/core/errors/codes.dart';
import 'package:simple_parking/core/errors/server_error.dart';
import 'package:simple_parking/core/failure/failure.dart';
import 'package:simple_parking/core/network/network_info.dart';
import 'package:simple_parking/feature/parking_spot/data/data_sources/local/location_datasoucre.dart';
import 'package:simple_parking/feature/parking_spot/data/data_sources/remote/parking_place_remote_datasource.dart';
import 'package:simple_parking/feature/parking_spot/data/repository/parking_location_repository_impl.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/error/location_error.dart';

class MockParkingPlaceRemoteDataSource extends Mock
    implements ParkingPlaceRemoteDataSourceImpl {}

class MockLocationDataSource extends Mock implements LocationDataSourceImpl {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

main() {
  MockParkingPlaceRemoteDataSource mockParkingPlaceRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  ParkingLocationRepositoryImpl parkingLocationRepositoryImpl;
  MockLocationDataSource mockLocationDataSource;
  setUp(() {
    mockParkingPlaceRemoteDataSource = MockParkingPlaceRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockLocationDataSource = MockLocationDataSource();

    parkingLocationRepositoryImpl = ParkingLocationRepositoryImpl(
        locationDataSource: mockLocationDataSource,
        parkingPlaceRemoteDataSource: mockParkingPlaceRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('getUserLocation', () {
    Location testLocation = Location(lat: 22.564, lng: 397.89);
    test('should return actual user location if permission is granted',
        () async {
      //arrange
      when(mockLocationDataSource.getLocation())
          .thenAnswer((_) async => testLocation);

      //act
      var result = await parkingLocationRepositoryImpl.getUserLocation();
      //assert
      expect(result, equals(testLocation));
    });

    test('test should return a default location on permission error', () async {
      //arrange
      when(mockLocationDataSource.getLocation())
          .thenThrow(LocationError(LocationErrorType.DENIED));

      //act
      var result = await parkingLocationRepositoryImpl.getUserLocation();

//assert
      verify(mockLocationDataSource.getLocation());
      expect(result, isInstanceOf<Location>());
    });
  });

  group('getNearbyParking', () {
    Location testLocation = Location(lat: 25.2, lng: 2772.8);
    List<ParkingPlace> testParkingPlace = [ParkingPlace()];
    test('should return network failure when there\'s no internet connection',
        () async {
      when(mockNetworkInfo.hasNetworkConnection())
          .thenAnswer((_) async => false);

      var result =
          await parkingLocationRepositoryImpl.getNearbyParking(testLocation);

      verifyZeroInteractions(mockLocationDataSource);
      expect(result, equals(Left(NetworkFailure(NETWORK_ERROR_MESSAGE))));
    });

    test('should return ServerFailure if request is not sucessfull', () async {
      //arrange
      when(mockNetworkInfo.hasNetworkConnection())
          .thenAnswer((_) async => true);

      when(mockParkingPlaceRemoteDataSource.getNearbyParking(testLocation))
          .thenThrow(ServerError());

//act
      var result =
          await parkingLocationRepositoryImpl.getNearbyParking(testLocation);
      verifyZeroInteractions(mockLocationDataSource);
      expect(result, Left(ServerFailure(SERVER_ERROR_MESSAGE)));
    });

    test('should return a list of [ParkingPlace] if request is successful',
        () async {
      when(mockNetworkInfo.hasNetworkConnection())
          .thenAnswer((_) async => true);

      when(mockParkingPlaceRemoteDataSource.getNearbyParking(any))
          .thenAnswer(((_) async => testParkingPlace));

      var result =
          await parkingLocationRepositoryImpl.getNearbyParking(testLocation);

      verifyZeroInteractions(mockLocationDataSource);
      verify(mockParkingPlaceRemoteDataSource.getNearbyParking(testLocation));
      expect(result, equals(Right(testParkingPlace)));
    });
  });
}

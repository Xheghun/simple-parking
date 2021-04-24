import 'package:dartz/dartz.dart';
import 'package:simple_parking/core/failure/failure.dart';
import 'package:simple_parking/feature/parking_spot/data/data_sources/local/location_datasoucre.dart';
import 'package:simple_parking/feature/parking_spot/data/data_sources/remote/parking_place_remote_datasource.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/parking_place.dart';
import 'package:simple_parking/feature/parking_spot/domain/repositories/parking_location_repository.dart';
import 'package:meta/meta.dart';
import 'package:simple_parking/feature/parking_spot/error/location_error.dart';
import 'package:simple_parking/feature/parking_spot/error/server_error.dart';

class ParkingLocationRepositoryImpl implements ParkingLocationRepository {
  final LocationDataSource locationDataSource;
  final ParkingPlaceRemoteDataSource parkingPlaceRemoteDataSource;

  ParkingLocationRepositoryImpl(
      {@required this.locationDataSource,
      @required this.parkingPlaceRemoteDataSource});

  @override
  Future<Location> getUserLocation() async {
    try {
      return locationDataSource.getLocation();
    } on LocationError {
      return Location(lat: 2992.228, lng: 272.3222);
    }
  }

  @override
  Future<Either<Failure, List<ParkingPlace>>> getNearbyParking(
      Location location) async {
    try {
      return Right(
          await parkingPlaceRemoteDataSource.getNearbyParking(location));
    } on ServerError {
      return Left(ServerFailure(
          message: "an error occurred while trying to process this request"));
    }
  }
}

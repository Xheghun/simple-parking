import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:simple_parking/core/errors/codes.dart';
import 'package:simple_parking/core/network/network_info.dart';

import '../../../../core/entities/parking_place.dart';
import '../../../../core/errors/server_error.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/parking_location_repository.dart';
import '../../error/location_error.dart';
import '../data_sources/local/location_datasoucre.dart';
import '../data_sources/remote/parking_place_remote_datasource.dart';

class ParkingLocationRepositoryImpl implements ParkingLocationRepository {
  final LocationDataSource locationDataSource;
  final ParkingPlaceRemoteDataSource parkingPlaceRemoteDataSource;
  final NetworkInfoContract networkInfo;

  ParkingLocationRepositoryImpl({
    @required this.locationDataSource,
    @required this.parkingPlaceRemoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Location> getUserLocation() async {
    try {
      return await locationDataSource.getLocation();
    } on LocationError catch (error) {
      print(error.type);
      print(error.message);
      return Location(lat: 25.197525, lng: 55.274288);
    }
  }

  @override
  Future<Either<Failure, List<ParkingPlace>>> getNearbyParking(
      Location location) async {
    if (await networkInfo.hasNetworkConnection()) {
      try {
        return Right(
            await parkingPlaceRemoteDataSource.getNearbyParking(location));
      } on ServerError {
        return Left(ServerFailure(SERVER_ERROR_MESSAGE));
      }
    } else {
      return Left(NetworkFailure(NETWORK_ERROR_MESSAGE));
    }
  }
}

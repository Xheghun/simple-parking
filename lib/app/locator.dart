import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/parking_spot/data/data_sources/local/location_datasoucre.dart';
import '../feature/parking_spot/data/data_sources/remote/parking_place_remote_datasource.dart';
import '../feature/parking_spot/data/repository/parking_location_repository_impl.dart';
import '../feature/parking_spot/domain/repositories/parking_location_repository.dart';
import '../feature/parking_spot/domain/use_case/get_parking_data.dart';
import '../feature/parking_spot/presentation/viewmodel/parking_map_viewmodel.dart';
import '../feature/saved_parking/data/data_sources/local/saved_parking_local_datascource.dart';
import '../feature/saved_parking/data/repository/saved_parking_repo_impl.dart';
import '../feature/saved_parking/domain/repositories/saved_parking_repo.dart';
import '../feature/saved_parking/domain/use_case/saved_parking_usecases_impl.dart';
import '../feature/saved_parking/presentation/viewmodel/saved_parking_viewmodel.dart';

var locator = GetIt.instance;

setupLocator() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //viewmodel
  locator
    ..registerFactory(() => ParkingMapViewmodel(locator()))
    ..registerFactory(() => SavedParkingViewModel(locator()))

    //use cases
    ..registerLazySingleton(() => GetParkingLocationData(
        parkingLocationRepository: locator(),
        savedParkingLocalRepository: locator()))
    ..registerLazySingleton(
        () => SavedParkingUseCasesImpl(savedParkingLocalRepository: locator()))
    //repository
    ..registerLazySingleton<ParkingLocationRepository>(() =>
        ParkingLocationRepositoryImpl(
            locationDataSource: locator(),
            parkingPlaceRemoteDataSource: locator()))
    ..registerLazySingleton<SavedParkingLocalRepository>(() =>
        SavedParkingLocalRepositoryImpl(savedParkingLocalDataSource: locator()))

    //data
    ..registerLazySingleton<LocationDataSource>(() => LocationDataSourceImpl())
    ..registerLazySingleton<ParkingPlaceRemoteDataSource>(
        () => ParkingPlaceRemoteDataSourceImpl(client: locator()))
    ..registerLazySingleton<SavedParkingLocalDataSource>(() =>
        SavedParkingPlaceLocalDataSourceImpl(sharedPreferences: locator()))

    //external
    ..registerLazySingleton(() => Dio())
    ..registerLazySingleton(() => sharedPreferences);
}

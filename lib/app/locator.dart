import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_parking/core/models/input_validatior.dart';
import 'package:simple_parking/core/network/network_info.dart';
import 'package:simple_parking/feature/parking_spot/data/data_sources/remote/search_place_remote_datasource.dart';
import 'package:simple_parking/feature/parking_spot/data/repository/search_suggestion_repo_impl.dart';
import 'package:simple_parking/feature/parking_spot/domain/repositories/search_suggestions_repo.dart';
import 'package:simple_parking/feature/parking_spot/domain/use_case/search_suggestion_use_cases.dart';
import 'package:simple_parking/feature/parking_spot/presentation/viewmodel/search_suggestion_viewmodel.dart';

import '../feature/parking_spot/data/data_sources/local/location_datasoucre.dart';
import '../feature/parking_spot/data/data_sources/remote/parking_place_remote_datasource.dart';
import '../feature/parking_spot/data/repository/parking_location_repository_impl.dart';
import '../feature/parking_spot/domain/repositories/parking_location_repository.dart';
import '../feature/parking_spot/domain/use_case/get_parking_data_use_case_impl.dart';
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
    ..registerFactory(() => ParkingMapViewmodel(locator(), locator()))
    ..registerFactory(() => SavedParkingViewModel(locator()))
    ..registerFactory(() => SearchSuggestionViewmodel(locator(), locator()))

    //use cases
    ..registerLazySingleton(() => GetParkingLocationData(
        parkingLocationRepository: locator(),
        savedParkingLocalRepository: locator()))
    ..registerLazySingleton(
        () => SavedParkingUseCasesImpl(savedParkingLocalRepository: locator()))
    ..registerLazySingleton(() => SearchSuggestionUseCaseImpl(locator()))
    //repository
    ..registerLazySingleton<ParkingLocationRepository>(
        () => ParkingLocationRepositoryImpl(
              locationDataSource: locator(),
              parkingPlaceRemoteDataSource: locator(),
              networkInfo: locator(),
            ))
    ..registerLazySingleton<SavedParkingLocalRepository>(() =>
        SavedParkingLocalRepositoryImpl(savedParkingLocalDataSource: locator()))
    ..registerLazySingleton<SearchSuggestionRepository>(() =>
        SearchSuggestionRepositoryImpl(
            searchPlaceRemoteDataSource: locator(),
            networkInfoContract: locator()))

    //helper
    ..registerLazySingleton<NetworkInfoContract>(() => NetworkInfo(locator()))
    ..registerLazySingleton<InputValidator>(() => InputValidatorImpl())

    //data
    ..registerLazySingleton<LocationDataSource>(() => LocationDataSourceImpl())
    ..registerLazySingleton<ParkingPlaceRemoteDataSource>(
        () => ParkingPlaceRemoteDataSourceImpl(client: locator()))
    ..registerLazySingleton<SavedParkingLocalDataSource>(() =>
        SavedParkingPlaceLocalDataSourceImpl(sharedPreferences: locator()))
    ..registerLazySingleton<SearchPlaceRemoteDataSource>(
        () => SearPlaceRemoteDataSourceImpl(locator()))

    //external
    ..registerLazySingleton(() => Dio())
    ..registerLazySingleton(() => sharedPreferences)
    ..registerLazySingleton(() => DataConnectionChecker());
}

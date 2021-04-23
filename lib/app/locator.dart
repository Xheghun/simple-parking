import 'package:get_it/get_it.dart';
import 'package:simple_parking/feature/parking_spot/data/data_sources/local/location_datasoucre.dart';
import 'package:simple_parking/feature/parking_spot/data/repository/parking_location_repository_impl.dart';
import 'package:simple_parking/feature/parking_spot/domain/repositories/parking_location_repository.dart';
import 'package:simple_parking/feature/parking_spot/domain/use_case/get_parking_data.dart';
import 'package:simple_parking/feature/parking_spot/presentation/viewmodel/parking_map_viewmodel.dart';

var locator = GetIt.instance;

setupLocator() {
  //viewmodel
  locator
    ..registerFactory(() => ParkingMapViewmodel(locator()))

    //use cases
    ..registerLazySingleton(() => GetParkingLocationData(locator()))

    //repository
    ..registerLazySingleton<ParkingLocationRepository>(
        () => ParkingLocationRepositoryImpl(locationDataSource: locator()))

    //data
    ..registerLazySingleton<LocationDataSource>(() => LocationDataSourceImpl());
}

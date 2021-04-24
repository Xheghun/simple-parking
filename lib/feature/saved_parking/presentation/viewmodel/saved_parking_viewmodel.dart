import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/core/viewmodel/base_viewmodel.dart';
import 'package:simple_parking/feature/saved_parking/domain/use_case/saved_parking_usecases.dart';

class SavedParkingViewModel extends BaseViewmodel {
  SavedParkingUseCases savedParkingUseCases;
  List<ParkingPlace> _parkingList = [];

  void getSavedParking() async {
    var result = await savedParkingUseCases.savedPlaces();

    result.fold((failure) {}, (savedPlaces) {});
  }
}

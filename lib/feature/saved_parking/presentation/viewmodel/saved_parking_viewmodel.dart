import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/core/viewmodel/base_viewmodel.dart';
import 'package:simple_parking/feature/saved_parking/domain/use_case/saved_parking_usecases_impl.dart';

class SavedParkingViewModel extends BaseViewmodel {
  final SavedParkingUseCasesImpl savedParkingUseCases;

  List<ParkingPlace> _parkingList = [];

  List<ParkingPlace> get parkingList => _parkingList;

  SavedParkingViewModel(this.savedParkingUseCases);

  void getSavedParking() async {
    var result = await savedParkingUseCases.savedPlaces();

    result.fold((failure) {
      print(failure.message);
    }, (savedPlaces) {
      savedPlaces.forEach((element) {
        if (!_parkingList.contains(element)) {
          _parkingList.add(element);
        }
      });
    });
    notifyListeners();
  }
}

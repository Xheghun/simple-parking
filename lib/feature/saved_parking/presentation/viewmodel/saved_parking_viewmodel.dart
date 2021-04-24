import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  void removePlace(BuildContext context, ParkingPlace place) async {
//dismiss dialog
    Navigator.pop(context);

    var result = await savedParkingUseCases.removePlace(place);
    result.fold((failure) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(failure.message)));
    }, (deleted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("deleted")));
      _parkingList.remove(place);
    });
    notifyListeners();
  }
}

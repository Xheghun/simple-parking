import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_parking/core/failure/failure.dart';
import 'package:simple_parking/core/viewmodel/base_viewmodel.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/parking_place.dart';
import 'package:simple_parking/feature/parking_spot/domain/use_case/get_parking_data.dart';

class ParkingMapViewmodel extends BaseViewmodel {
  final GetParkingLocationData _parkingLocationData;

  Completer<GoogleMapController> _controller = Completer();

  Location _location = Location(lat: 27.2, lng: 22.3);
  List<ParkingPlace> _parkingPlaces = [];

  ParkingMapViewmodel(this._parkingLocationData);

  Completer get controller => _controller;
  Location get location => _location;
  List<ParkingPlace> get parkingPlaces => _parkingPlaces;

  void _getParkingPlaces() async {
    var response = await _parkingLocationData.getNearbyParking(location);
    response.fold((failure) {
      if (failure is ServerFailure) print(failure.message);
    }, (parkingLocations) {
      _parkingPlaces = parkingLocations;
    });
    notifyListeners();
  }

  void setCameraPosition() async {
    Location location = await _parkingLocationData.getUserPosition();
    GoogleMapController tempMapController = await _controller.future;

    _getParkingPlaces();

    var camPosition = CameraPosition(
        zoom: 15,
        bearing: 30,
        tilt: 80,
        target: LatLng(location.lat, location.lng));

    tempMapController
        .animateCamera(CameraUpdate.newCameraPosition(camPosition));
    notifyListeners();
  }
}

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_parking/core/viewmodel/base_viewmodel.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/domain/use_case/get_parking_data.dart';

class ParkingMapViewmodel extends BaseViewmodel {
  final GetParkingLocationData _parkingLocationData;
  Completer<GoogleMapController> _controller = Completer();

  UserLocation _location = UserLocation(lat: 27.2, lng: 22.3);

  ParkingMapViewmodel(this._parkingLocationData);

  Completer get controller => _controller;
  UserLocation get location => _location;

  void setCameraPosition() async {
    UserLocation location = await _parkingLocationData.getUserPosition();
    GoogleMapController tempMapController = await _controller.future;

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

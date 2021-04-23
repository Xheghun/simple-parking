import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_parking/core/viewmodel/base_viewmodel.dart';
import 'package:simple_parking/feature/parking_spot/domain/use_case/get_parking_data.dart';

class ParkingMapViewmodel extends BaseViewmodel {
  final GetParkingLocationData _parkingLocationData;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _cameraPosition = CameraPosition(target: LatLng(0, 0));

  ParkingMapViewmodel(this._parkingLocationData);

  Completer get controller => _controller;
  CameraPosition get cameraPosition => _cameraPosition;

  void setCameraPosition() async {
    _cameraPosition = await _parkingLocationData.getCameraPosition();
    notifyListeners();
  }
}

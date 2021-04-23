import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_parking/core/viewmodel/base_viewmodel.dart';

class ParkingMapViewmodel extends BaseViewmodel {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(27.2046, 77.4977),
      zoom: 19.151926040649414);

  get controller => _controller;
  get initialPosition => _kGooglePlex;
}

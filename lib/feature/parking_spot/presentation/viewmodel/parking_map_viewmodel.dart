import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_parking/app/util/helpers.dart';
import 'package:simple_parking/core/network/network_info.dart';

import '../../../../core/entities/parking_place.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/viewmodel/base_viewmodel.dart';
import '../../domain/entities/location.dart';
import '../../domain/use_case/get_parking_data_use_case_impl.dart';
import '../widget/parking_info.dart';

class ParkingMapViewmodel extends BaseViewmodel {
  final GetParkingLocationData _parkingLocationData;
  final NetworkInfoContract _networkInfoContract;

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _parkingMarkers = HashSet<Marker>();
  Location _location = Location(lat: 25.197525, lng: 55.274288);

  var customMarker = BitmapDescriptor.fromAssetImage(
    ImageConfiguration(
      devicePixelRatio: 2.5,
    ),
    'assets/images/parked_car.jpg',
  );

  ParkingMapViewmodel(this._parkingLocationData, this._networkInfoContract);

  Completer get controller => _controller;
  Location get location => _location;
  set location(Location location) {
    _location = location;
    notifyListeners();
  }

  Set<Marker> get parkingMarkers => _parkingMarkers;
  Future<bool> get hasNetwork async =>
      await _networkInfoContract.hasNetworkConnection();

  void getParkingPlaces(context, {LatLng position}) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    Location camLocation;
    if (position != null)
      camLocation = Location(lat: position.latitude, lng: position.longitude);

    var response =
        await _parkingLocationData.getNearbyParking(camLocation ?? _location);
    response.fold((failure) {
      if (failure is ServerFailure) print(failure.message);
      if (failure is NetworkFailure)
        snackbar(
          context,
          text: failure.message,
          duration: Duration(seconds: 3),
        );
    }, (parkingLocations) {
      parkingLocations.forEach((element) async {
        _parkingMarkers.add(
          Marker(
            icon: await customMarker,
            infoWindow: InfoWindow(
              title: element.name,
            ),
            onTap: () => showMarkerInfo(context, element),
            markerId: MarkerId("parking_place_${element.placeId}"),
            position: LatLng(element.location.lat, element.location.lng),
          ),
        );
      });
    });
    notifyListeners();
  }

  Future setCameraPosition({LatLng loc}) async {
    LatLng tempLocation;
    if (loc == null) {
      _location = await _parkingLocationData.getUserPosition();
      tempLocation = LatLng(location.lat, location.lng);
    } else {
      tempLocation = loc;
    }
    notifyListeners();
    GoogleMapController tempMapController = await _controller.future;

    var camPosition =
        CameraPosition(zoom: 16, bearing: 30, tilt: 80, target: tempLocation);

    tempMapController
        .animateCamera(CameraUpdate.newCameraPosition(camPosition));
  }

  void savePlace(BuildContext context, ParkingPlace place) async {
//dismiss bottom sheet
    Navigator.pop(context);

    var result = await _parkingLocationData.savePlace(place);

    result.fold((cacheFailure) {
      snackbar(context, text: cacheFailure.message);
    }, (saved) {
      snackbar(context, text: "saved");
    });
  }

  void showMarkerInfo(BuildContext context, ParkingPlace parkingPlace) {
    showMaterialModalBottomSheet(
        context: context,
        expand: false,
        builder: (ctx) {
          return ParkingInfo(
              parkingPlace: parkingPlace,
              onButtonPressed: () => savePlace(context, parkingPlace));
        });
  }
}

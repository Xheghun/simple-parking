import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/entities/parking_place.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/viewmodel/base_viewmodel.dart';
import '../../domain/entities/location.dart';
import '../../domain/use_case/get_parking_data.dart';
import '../widget/parking_info.dart';

class ParkingMapViewmodel extends BaseViewmodel {
  final GetParkingLocationData _parkingLocationData;

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _parkingMarkers = HashSet<Marker>();
  Location _location = Location(lat: 25.197525, lng: 55.274288);

  BitmapDescriptor customMarker;

  ParkingMapViewmodel(this._parkingLocationData) {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              devicePixelRatio: 2.5,
            ),
            'assets/images/parked-car.png')
        .then((onValue) {
      customMarker = onValue;
    });
  }

  Completer get controller => _controller;
  Location get location => _location;
  Set<Marker> get parkingMarkers => _parkingMarkers;

  void getParkingPlaces(context, {LatLng position}) async {
    Location camLocation;
    if (position != null)
      camLocation = Location(lat: position.latitude, lng: position.longitude);

    var response =
        await _parkingLocationData.getNearbyParking(camLocation ?? _location);
    response.fold((failure) {
      if (failure is ServerFailure) print(failure.message);
    }, (parkingLocations) {
      parkingLocations.forEach((element) async {
        _parkingMarkers.add(
          Marker(
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

  Future setCameraPosition() async {
    _location = await _parkingLocationData.getUserPosition();
    notifyListeners();
    GoogleMapController tempMapController = await _controller.future;

    var camPosition = CameraPosition(
        zoom: 15,
        bearing: 30,
        tilt: 80,
        target: LatLng(location.lat, location.lng));

    tempMapController
        .animateCamera(CameraUpdate.newCameraPosition(camPosition));
  }

  void savePlace(BuildContext context, ParkingPlace place) async {
//dismiss bottom sheet
    Navigator.pop(context);

    var result = await _parkingLocationData.savePlace(place);

    snackbar(String text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }

    result.fold((cacheFailure) {
      snackbar(cacheFailure.message);
    }, (saved) {
      snackbar("saved!");
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

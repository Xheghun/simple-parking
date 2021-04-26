import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';

import '../viewmodel/parking_map_viewmodel.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget>
    with AfterLayoutMixin<MapWidget> {
  ParkingMapViewmodel _model;

  @override
  Widget build(BuildContext context) {
    _model = context.watch<ParkingMapViewmodel>();
    return Listener(
      child: GoogleMap(
        myLocationEnabled: true,
        onCameraIdle: () {
          _model.getParkingPlaces(context);
        },
        onCameraMove: (position) {
          _model.location = Location(
              lat: position.target.latitude, lng: position.target.longitude);
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            zoom: 15, target: LatLng(_model.location.lat, _model.location.lng)),
        onMapCreated: (GoogleMapController controller) {
          _model.controller.complete(controller);
        },
        markers: _model.parkingMarkers,
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _model.setCameraPosition().then((value) {
      _model.getParkingPlaces(context);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:simple_parking/feature/parking_spot/presentation/viewmodel/parking_map_viewmodel.dart';

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
    return GoogleMap(
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          target: LatLng(_model.location.lat, _model.location.lng)),
      onMapCreated: (GoogleMapController controller) {
        _model.controller.complete(controller);
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _model.setCameraPosition().then((value) {
      _model.getParkingPlaces();
    });
  }
}

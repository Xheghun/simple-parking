import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/feature/parking_spot/presentation/viewmodel/parking_map_viewmodel.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingMapViewmodel>(builder: (context, model, _) {
      return GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: model.initialPosition,
        onMapCreated: (GoogleMapController controller) {
          model.controller.complete(controller);
        },
      );
    });
  }
}

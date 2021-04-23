import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/feature/parking_spot/presentation/viewmodel/parking_map_viewmodel.dart';

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingMapViewmodel>(
      builder: (context, model, _) {
        model.setCameraPosition();
        return GoogleMap(
          mapType: MapType.terrain,
          initialCameraPosition: model.cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            model.controller.complete(controller);
          },
        );
      },
    );
  }
}

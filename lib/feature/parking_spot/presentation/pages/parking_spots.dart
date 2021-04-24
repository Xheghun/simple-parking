import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/locator.dart';
import '../../domain/use_case/get_parking_data.dart';
import '../viewmodel/parking_map_viewmodel.dart';
import '../widget/widget.dart';

class ParkingSpots extends StatelessWidget {
  static const routeName = "/parkingSpot";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParkingMapViewmodel(locator<GetParkingLocationData>()),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              MapWidget(),
              SearchBar(),
            ],
          ),
        ),
      ),
    );
  }
}

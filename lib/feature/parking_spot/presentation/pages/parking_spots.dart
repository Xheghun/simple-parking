import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/feature/parking_spot/presentation/viewmodel/parking_map_viewmodel.dart';
import '../widget/widget.dart';

class ParkingSpots extends StatelessWidget {
  static const routeName = "/parkingSpot";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParkingMapViewmodel(),
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

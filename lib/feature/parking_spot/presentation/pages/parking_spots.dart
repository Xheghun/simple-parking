import 'package:flutter/material.dart';
import '../widget/widget.dart';

class ParkingSpots extends StatelessWidget {
  static const routeName = "/parkingSpot";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MapWidget(),
            SearchBar(),
          ],
        ),
      ),
    );
  }
}

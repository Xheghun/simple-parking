import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/app/util/helpers.dart';
import 'package:simple_parking/core/errors/codes.dart';

import '../../../../app/locator.dart';
import '../viewmodel/parking_map_viewmodel.dart';
import '../widget/widget.dart';

class ParkingSpots extends StatelessWidget {
  static const routeName = "/parkingSpot";

  void networkCheck(BuildContext context, ParkingMapViewmodel model) async {
    if (!await model.hasNetwork)
      snackbar(context,
          text: NETWORK_ERROR_MESSAGE, duration: Duration(minutes: 5));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParkingMapViewmodel(locator(), locator()),
      child: Consumer<ParkingMapViewmodel>(
        builder: (context, model, _) {
          networkCheck(context, model);
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
        },
      ),
    );
  }
}

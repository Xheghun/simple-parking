import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/app/util/helpers.dart';
import 'package:simple_parking/core/errors/codes.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/presentation/pages/search_page.dart';

import '../../../../app/locator.dart';
import '../viewmodel/parking_map_viewmodel.dart';
import '../widget/widget.dart';

class ParkingSpots extends StatelessWidget {
  static const routeName = "/parkingSpot";

  void networkCheck(BuildContext context, ParkingMapViewmodel model) async {
    if (!await model.hasNetwork)
      snackbar(context,
          text: NETWORK_ERROR_MESSAGE, duration: Duration(seconds: 3));
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
                  SearchBar(
                    readOnly: true,
                    onTap: () async {
                      var result = await Navigator.pushNamed(
                          context, SearchPage.routeName);

                      if (result is Location) {
                        model.setCameraPosition(
                            loc: LatLng(result.lat, result.lng));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_parking/app/res/theme.dart';
import 'package:simple_parking/app/route_generator.dart';

import 'routes.dart';

class SimpleParking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: AppTheme.defaultTheme(),
      initialRoute: ParkingSpots.routeName,
    );
  }
}

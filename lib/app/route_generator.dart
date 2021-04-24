import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_parking/app/main/main_screen_holder.dart';

import 'routes.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ParkingSpots.routeName:
        return MaterialPageRoute(
          builder: (_) => ParkingSpots(),
          settings: RouteSettings(name: ParkingSpots.routeName),
        );

      case MainScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => MainScreen(),
          settings: RouteSettings(name: MainScreen.routeName),
        );

      case SavedSpots.routeName:
        return MaterialPageRoute(
          builder: (_) => SavedSpots(),
          settings: RouteSettings(name: SavedSpots.routeName),
        );

      default:
        return null;
    }
  }
}

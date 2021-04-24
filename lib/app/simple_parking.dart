import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:simple_parking/app/main/main_screen_holder.dart';
import 'package:simple_parking/app/res/theme.dart';
import 'package:simple_parking/app/route_generator.dart';

class SimpleParking extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: AppTheme.defaultTheme(),
      initialRoute: MainScreen.routeName,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}

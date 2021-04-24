import 'package:flutter/material.dart';
import 'package:simple_parking/app/locator.dart';
import 'package:simple_parking/app/simple_parking.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(SimpleParking());
}

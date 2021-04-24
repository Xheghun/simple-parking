import 'package:flutter/material.dart';

import 'app/locator.dart';
import 'app/simple_parking.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(SimpleParking());
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/locator.dart';
import '../viewmodel/saved_parking_viewmodel.dart';
import '../widget/widget.dart';

class SavedSpots extends StatelessWidget {
  static const routeName = "/savedSpot";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return ChangeNotifierProvider(
      create: (_) => SavedParkingViewModel(locator()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Favorite Parking", style: theme.textTheme.headline1),
        ),
        body: Container(
          padding:
              EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.05),
          child: FavoriteParkingList(),
        ),
      ),
    );
  }
}

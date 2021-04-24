import 'package:flutter/material.dart';
import '../widget/widget.dart';

class SavedSpots extends StatelessWidget {
  static const routeName = "/savedSpot";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Parking", style: theme.textTheme.headline1),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.05),
        child: FavoriteParkingList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

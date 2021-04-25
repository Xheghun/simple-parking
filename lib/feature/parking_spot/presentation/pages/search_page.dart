import 'package:flutter/material.dart';
import 'package:simple_parking/feature/parking_spot/presentation/widget/widget.dart';

class SearchPage extends StatelessWidget {
  static const routeName = "/searchPage";

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 0,
          title: SearchBar(
            prefixIcon: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            margin: EdgeInsets.zero,
            hintText: "Enter city name",
          )),
      body: Center(
        child: Text(
          "results will appear here",
          style: theme.textTheme.bodyText2,
        ),
      ),
    );
  }
}

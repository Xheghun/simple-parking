import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  static const routeName = "/searchPage";

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            hintText: "Enter city name",
            
          ),
        ),
      ),
    );
  }
}

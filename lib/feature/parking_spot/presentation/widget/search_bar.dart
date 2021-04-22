import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(
          vertical: mediaQuery.size.height * 0.05,
          horizontal: mediaQuery.size.width * 0.1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: []),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: "Search location..."),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_parking/app/res/style.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: mediaQuery.size.height * 0.05,
          horizontal: mediaQuery.size.width * 0.1),
      child: Material(
        elevation: 2,
        borderRadius: AppStyle.borderRadius25,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            readOnly: true,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintText: "Search location...",
                hintStyle: theme.textTheme.subtitle2),
          ),
        ),
      ),
    );
  }
}

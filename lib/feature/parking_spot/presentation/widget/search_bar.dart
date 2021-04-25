import 'package:flutter/material.dart';
import '../../../../app/res/style.dart';

class SearchBar extends StatelessWidget {
  final Function onTap;
  final bool readOnly;
  final EdgeInsets margin;
  final Widget prefixIcon;
  final String hintText;

  const SearchBar(
      {Key key,
      this.prefixIcon,
      this.hintText = "Search location...",
      this.margin,
      this.readOnly = false,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    return Container(
      margin: margin ??
          EdgeInsets.symmetric(
              vertical: mediaQuery.size.height * 0.05,
              horizontal: mediaQuery.size.width * 0.1),
      child: Material(
        elevation: 2,
        borderRadius: AppStyle.borderRadius25,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            onTap: onTap,
            readOnly: readOnly,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: prefixIcon ?? Icon(Icons.search),
                hintText:  hintText,
                hintStyle: theme.textTheme.subtitle2),
          ),
        ),
      ),
    );
  }
}

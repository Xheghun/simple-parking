import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_parking/app/res/colors.dart';

class EmptyState extends StatelessWidget {
  final String text;

  const EmptyState({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/svg/empty.svg",
          width: 100,
          height: 100,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: theme.textTheme.bodyText2,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:simple_parking/app/res/colors.dart';

class RatingBarWidget extends StatelessWidget {
  final num rating;
  final double size;

  const RatingBarWidget({Key key, this.size = 15, this.rating = 2.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.readOnly(
        filledIcon: Icons.star,
        filledColor: colorPrimary,
        halfFilledColor: colorPrimary,
        size: size,
        emptyColor: colorPrimary,
        initialRating: rating.toDouble() ?? 0,
        isHalfAllowed: true,
        maxRating: 5,
        halfFilledIcon: Icons.star_half,
        emptyIcon: Icons.star_outline);
  }
}

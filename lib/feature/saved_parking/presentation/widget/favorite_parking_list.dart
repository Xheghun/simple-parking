import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_parking/app/res/string.dart';
import 'package:simple_parking/app/res/style.dart';
import 'package:simple_parking/feature/saved_parking/presentation/widget/widget.dart';

class FavoriteParkingList extends StatelessWidget {

  Widget _distance() {
    return ();
  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListView.separated(
      itemCount: 12,
      separatorBuilder: (_, __) => Container(
        height: 6,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: AppStyle.borderRadius6,
            child: Material(
              elevation: 4,
              child: Image.asset(
                "${imagePath}parking.jpg",
                fit: BoxFit.cover,
                height: 200,
                width: 80,
              ),
            ),
          ),
          title: Text(
            "Dubai Mall",
            style: theme.textTheme.headline2,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RatingBarWidget(),

            ],
          ),
        );
      },
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_parking/app/res/colors.dart';
import 'package:simple_parking/app/res/string.dart';
import 'package:simple_parking/app/res/style.dart';
import 'package:simple_parking/feature/saved_parking/presentation/widget/widget.dart';

class FavoriteParkingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Widget _distance() {
      return Container(
        child: Row(
          children: [
            Icon(
              Icons.directions_run,
              size: 15,
              color: colorPrimary,
            ),
            Text(
              "4 km",
              style: theme.textTheme.subtitle2,
            )
          ],
        ),
      );
    }

    Widget _location() {
      return Container(
        child: Row(
          children: [
            Text(
              "Downtown Dubai",
              style: theme.textTheme.subtitle2,
            ),
            SizedBox(
              width: 4,
            ),
            Icon(
              Icons.location_on,
              size: 14,
              color: colorPrimary,
            )
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: 12,
      padding: EdgeInsets.symmetric(vertical: 12),
      separatorBuilder: (_, __) => Container(
        height: 6,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: AppStyle.borderRadius3,
            child: Container(
              height: 200,
              width: 80,
              child: Material(
                elevation: 4,
                child: Image.asset(
                  "${imagePath}parking.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          title: Text(
            "Dubai Mall",
            style: theme.textTheme.headline2,
          ),
          subtitle: Column(
            children: [
              SizedBox(
                height: 3,
              ),
              _location(),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [RatingBarWidget(), _distance()],
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/app/res/colors.dart';
import 'package:simple_parking/app/res/string.dart';
import 'package:simple_parking/app/res/style.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/feature/saved_parking/presentation/viewmodel/saved_parking_viewmodel.dart';
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

    Widget _location({String text = "spot"}) {
      return Container(
        child: Row(
          children: [
            Text(
              text,
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

    return Consumer<SavedParkingViewModel>(
      builder: (context, model, index) {
        return ListView.separated(
          itemCount: model.parkingList.length,
          padding: EdgeInsets.symmetric(vertical: 12),
          separatorBuilder: (_, __) => Container(
            height: 6,
          ),
          itemBuilder: (context, index) {
            ParkingPlace parkingPlace = model.parkingList[index];

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
                      child: FadeInImage(
                        placeholder: AssetImage("${imagePath}parking.jpg"),
                        image: CachedNetworkImageProvider(parkingPlace.icon),
                      )),
                ),
              ),
              title: Text(
                parkingPlace.name,
                style: theme.textTheme.headline2,
              ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  _location(text: parkingPlace.vicinity),
                  SizedBox(
                    height: 4,
                  ),
                  RatingBarWidget(
                    size: parkingPlace.rating,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

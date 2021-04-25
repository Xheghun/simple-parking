import 'package:flutter/material.dart';

import '../../../../app/res/colors.dart';
import '../../../../app/res/style.dart';
import '../../../../core/entities/parking_place.dart';
import '../../../saved_parking/presentation/widget/rating_bar.dart';

class ParkingInfo extends StatelessWidget {
  final ParkingPlace parkingPlace;
  final Function onButtonPressed;
  final bool isSave;

  const ParkingInfo(
      {Key key, this.isSave = true, this.onButtonPressed, this.parkingPlace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    Widget saveButton() {
      return ClipRRect(
        borderRadius: AppStyle.borderRadius6,
        child: Material(
          color: colorPrimary,
          child: InkWell(
            onTap: onButtonPressed ?? () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                isSave ? "Save" : "Remove",
                style: theme.textTheme.button,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.05,
          vertical: screenSize.height * 0.03),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              parkingPlace.name,
              style: theme.textTheme.headline2,
            ),
          ),
          Text(
            parkingPlace.vicinity,
            style: theme.textTheme.bodyText1,
          ),
          SizedBox(height: 8,),
          Text(
            "Location: ${parkingPlace.location.lat} ${parkingPlace.location.lng}",
            style: theme.textTheme.bodyText1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                RatingBarWidget(
                  rating: parkingPlace.rating,
                  size: 22,
                ),
                Expanded(
                  child: SizedBox(),
                ),
                saveButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

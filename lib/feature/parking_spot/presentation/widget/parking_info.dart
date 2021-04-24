import 'package:flutter/material.dart';
import 'package:simple_parking/app/res/colors.dart';
import 'package:simple_parking/app/res/style.dart';
import 'package:simple_parking/core/entities/parking_place.dart';
import 'package:simple_parking/feature/saved_parking/presentation/widget/rating_bar.dart';

class ParkingInfo extends StatelessWidget {
  final ParkingPlace parkingPlace;

  const ParkingInfo({Key key, this.parkingPlace}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
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
                ClipRRect(
                  borderRadius: AppStyle.borderRadius6,
                  child: Material(
                    color: colorPrimary,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Text(
                          "Save",
                          style: theme.textTheme.button,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

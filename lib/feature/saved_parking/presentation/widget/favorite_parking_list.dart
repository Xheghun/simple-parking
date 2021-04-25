import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/app/widget/empty_list.dart';
import '../../../../app/res/colors.dart';
import '../../../../app/res/string.dart';
import '../../../../app/res/style.dart';
import '../../../../core/entities/parking_place.dart';
import '../../../parking_spot/presentation/widget/parking_info.dart';
import '../viewmodel/saved_parking_viewmodel.dart';
import 'widget.dart';

class FavoriteParkingList extends StatefulWidget {
  @override
  _FavoriteParkingListState createState() => _FavoriteParkingListState();
}

class _FavoriteParkingListState extends State<FavoriteParkingList>
    with AfterLayoutMixin {
  SavedParkingViewModel _model;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    _model = context.watch<SavedParkingViewModel>();

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

    return (_model.parkingList.isEmpty)
        ? Center(
            child: EmptyState(
            text: "no data",
          ))
        : ListView.separated(
            itemCount: _model.parkingList.length,
            padding: EdgeInsets.symmetric(vertical: 12),
            separatorBuilder: (_, __) => Container(
              height: 6,
            ),
            itemBuilder: (context, index) {
              ParkingPlace parkingPlace = _model.parkingList[index];

              return ListTile(
                onTap: () {
                  showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) => ParkingInfo(
                            parkingPlace: parkingPlace,
                            isSave: false,
                            onButtonPressed: () =>
                                _model.removePlace(context, parkingPlace),
                          ));
                },
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
                    Row(
                      children: [
                        RatingBarWidget(
                          rating: parkingPlace.rating,
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _model.getSavedParking();
  }
}

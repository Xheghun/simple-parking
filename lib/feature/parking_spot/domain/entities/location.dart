import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double lat;
  final double lng;
  Location({this.lat, this.lng});

  @override
  List<Object> get props => [lat, lng];
}

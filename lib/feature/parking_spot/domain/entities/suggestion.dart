import 'package:equatable/equatable.dart';

class Suggestion extends Equatable {
  String description;
  String placeId;
  String reference;
  Suggestion({this.description, this.placeId, this.reference});

  @override
  // TODO: implement props
  List<Object> get props => [placeId];
}

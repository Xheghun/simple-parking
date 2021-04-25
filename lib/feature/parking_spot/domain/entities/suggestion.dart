import 'package:equatable/equatable.dart';

class Suggestion extends Equatable {
  final String description;
  final String placeId;
  final String reference;
  Suggestion({this.description, this.placeId, this.reference});

  @override
  List<Object> get props => [placeId];
}

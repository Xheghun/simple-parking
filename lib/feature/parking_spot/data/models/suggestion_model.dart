import 'package:simple_parking/feature/parking_spot/domain/entities/suggestion.dart';

class SuggestionModel extends Suggestion {
  SuggestionModel({
    String description,
    String placeId,
    String reference,
  }) : super(
          description: description,
          placeId: placeId,
          reference: reference,
        );

  factory SuggestionModel.fromJson(Map<String, dynamic> json) =>
      SuggestionModel(
        description: json["description"] == null ? null : json["description"],
        placeId: json["place_id"] == null ? null : json["place_id"],
        reference: json["reference"] == null ? null : json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "description": description == null ? null : description,
        "place_id": placeId == null ? null : placeId,
        "reference": reference == null ? null : reference,
      };
}

class SuggestionModel {
  SuggestionModel({
    this.description,
    this.placeId,
    this.reference,
  });

  String description;
  String placeId;
  String reference;

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

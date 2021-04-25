import 'package:dartz/dartz.dart';
import 'package:simple_parking/core/failure/failure.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/location.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/suggestion.dart';

abstract class SearchSuggestionRepository {
  Future<Either<Failure, List<Suggestion>>> getSuggestions(String input);
  Future<Either<Failure, Location>> getPlaceLocation(String placeId);
}

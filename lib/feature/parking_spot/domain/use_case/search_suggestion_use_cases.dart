import 'package:dartz/dartz.dart';
import 'package:simple_parking/core/failure/failure.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/suggestion.dart';
import 'package:simple_parking/feature/parking_spot/domain/repositories/search_suggestions_repo.dart';

abstract class SearchSuggestionUseCase {
  Future<Either<Failure, List<Suggestion>>> getSuggestions(String input);
}

class SearchSuggestionUseCaseImpl implements SearchSuggestionUseCase {
  final SearchSuggestionRepository searchSuggestionRepository;

  SearchSuggestionUseCaseImpl(this.searchSuggestionRepository);
  @override
  Future<Either<Failure, List<Suggestion>>> getSuggestions(String input) =>
      searchSuggestionRepository.getSuggestions(input);
}

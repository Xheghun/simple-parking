import 'package:simple_parking/core/errors/codes.dart';
import 'package:simple_parking/core/errors/server_error.dart';
import 'package:simple_parking/core/network/network_info.dart';
import 'package:simple_parking/feature/parking_spot/data/data_sources/remote/search_place_remote_datasource.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/suggestion.dart';
import 'package:simple_parking/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_parking/feature/parking_spot/domain/repositories/search_suggestions_repo.dart';
import 'package:meta/meta.dart';

class SearchSuggestionRepositoryImpl implements SearchSuggestionRepository {
  final SearchPlaceRemoteDataSource searchPlaceRemoteDataSource;

  final NetworkInfoContract networkInfoContract;

  SearchSuggestionRepositoryImpl(
      {@required this.searchPlaceRemoteDataSource,
      @required this.networkInfoContract});

  @override
  Future<Either<Failure, List<Suggestion>>> getSuggestions(String input) async {
    if (await networkInfoContract.hasNetworkConnection()) {
      try {
        return Right(await searchPlaceRemoteDataSource.citySuggestions(input));
      } on ServerError {
        return Left(ServerFailure(SERVER_ERROR_MESSAGE));
      }
    } else {
      return Left(NetworkFailure(NETWORK_ERROR_MESSAGE));
    }
  }
}

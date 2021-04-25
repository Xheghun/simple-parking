import 'package:flutter/widgets.dart';
import 'package:simple_parking/app/util/helpers.dart';
import 'package:simple_parking/core/failure/failure.dart';
import 'package:simple_parking/core/viewmodel/base_viewmodel.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/suggestion.dart';
import 'package:simple_parking/feature/parking_spot/domain/use_case/search_suggestion_use_cases.dart';

class SearchSuggestionViewmodel extends BaseViewmodel {
  final SearchSuggestionUseCaseImpl searchSuggestionUseCaseImpl;

  SearchSuggestionViewmodel(this.searchSuggestionUseCaseImpl);

  TextEditingController controller = TextEditingController();
  List<Suggestion> _suggestions = [];

  void getSuggestions(BuildContext context) async {
    var result =
        await searchSuggestionUseCaseImpl.getSuggestions(controller.text);
    result.fold((failure) {
      if (failure is NetworkFailure) {
        snackbar(context, text: failure.message);
      }
    }, (suggestions) {
      _suggestions.forEach((element) {
        if (!_suggestions.contains(element)) {
          _suggestions.add(element);
        }
      });
    });
  }
}

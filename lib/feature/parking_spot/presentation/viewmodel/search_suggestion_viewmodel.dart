import 'package:flutter/widgets.dart';
import 'package:simple_parking/app/util/helpers.dart';
import 'package:simple_parking/core/enum/view_state.dart';
import 'package:simple_parking/core/failure/failure.dart';
import 'package:simple_parking/core/models/input_validatior.dart';
import 'package:simple_parking/core/viewmodel/base_viewmodel.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/suggestion.dart';
import 'package:simple_parking/feature/parking_spot/domain/use_case/search_suggestion_use_cases.dart';

class SearchSuggestionViewmodel extends BaseViewmodel {
  final SearchSuggestionUseCaseImpl searchSuggestionUseCaseImpl;
  final InputValidator inputValidator;

  SearchSuggestionViewmodel(
      this.searchSuggestionUseCaseImpl, this.inputValidator);

  TextEditingController controller = TextEditingController();
  List<Suggestion> _suggestions = [];

  List<Suggestion> get suggestions => _suggestions;

  void validateInput(BuildContext context) {
    if (inputValidator.notEmpty(controller.text)) {
      _getSuggestions(context);
    }
  }

  void _getSuggestions(BuildContext context) async {
//notify UI
    changeState(ViewState.Busy);

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
    changeState(ViewState.Idle);
  }
}

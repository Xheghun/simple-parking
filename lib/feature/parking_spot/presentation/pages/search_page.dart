import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/app/locator.dart';
import 'package:simple_parking/feature/parking_spot/presentation/viewmodel/search_suggestion_viewmodel.dart';
import 'package:simple_parking/feature/parking_spot/presentation/widget/widget.dart';

class SearchPage extends StatelessWidget {
  static const routeName = "/searchPage";

  Widget body(SearchSuggestionViewmodel model) {
    if (model.isBusy()) {
     return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if(model.s)
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => SearchSuggestionViewmodel(locator(), locator()),
      child: Consumer<SearchSuggestionViewmodel>(
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(
                leadingWidth: 0,
                title: SearchBar(
                  controller: model.controller,
                  textInputAction: TextInputAction.go,
                  onSubmit: () => model.validateInput(context),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  margin: EdgeInsets.zero,
                  hintText: "Enter city name",
                )),
            body: Center(
              child: Text(
                "results will appear here",
                style: theme.textTheme.bodyText2,
              ),
            ),
          );
        },
      ),
    );
  }
}

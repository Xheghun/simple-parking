import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/app/locator.dart';
import 'package:simple_parking/app/widget/empty_list.dart';
import 'package:simple_parking/feature/parking_spot/domain/entities/suggestion.dart';
import 'package:simple_parking/feature/parking_spot/presentation/viewmodel/search_suggestion_viewmodel.dart';
import 'package:simple_parking/feature/parking_spot/presentation/widget/widget.dart';

class SearchPage extends StatelessWidget {
  static const routeName = "/searchPage";

  @override
  Widget build(BuildContext context) {


    Widget _body(SearchSuggestionViewmodel model) {
      void getLocation(String placeId) {
        Navigator.pop(context, model.getPlaceLocation(context, placeId));
      }

      if (model.isBusy()) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (model.suggestions.isEmpty) {
          return Center(child: EmptyState(text: "results will appear here"));
        }
        return ListView.builder(
          itemCount: model.suggestions.length,
          itemBuilder: (context, index) {
            Suggestion suggestion = model.suggestions[index];
            return ListTile(
              onTap: () => getLocation(suggestion.placeId),
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.location_on),
              title: Text(suggestion.description),
            );
          },
        );
      }
    }

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
                  onSubmit: (_) => model.validateInput(context),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  margin: EdgeInsets.zero,
                  hintText: "Enter city name",
                )),
            body: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: _body(model)),
          );
        },
      ),
    );
  }
}

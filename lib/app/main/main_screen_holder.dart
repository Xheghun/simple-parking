import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/colors.dart';
import 'main_screen_viemodel.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/mainScreen";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainScreenViewModel(),
      child: Consumer<MainScreenViewModel>(
        builder: (context, model, _) {
          return Scaffold(
            body: model.pages[model.currentPage],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(canvasColor: colorPrimary),
              child: BottomNavigationBar(
                onTap: model.changeItem,
                currentIndex: model.currentPage,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.book), label: 'Saved'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

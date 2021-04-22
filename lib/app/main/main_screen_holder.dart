import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_parking/app/main/main_screen_viemodel.dart';
import 'package:simple_parking/app/res/colors.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/mainScreen";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainScreenViewModel(),
      child: Consumer<MainScreenViewModel>(
        builder: (context, model, _) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              onTap: model.changeItem,
              currentIndex: model.currentPage,
              type: BottomNavigationBarType.shifting,
              showUnselectedLabels: false,
              selectedItemColor: colorPrimary,
              unselectedItemColor: colorPrimaryLight,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Saved'),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_parking/app/res/colors.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentItem = 0;
  void changeItem(int page) {
    setState(() {
      _currentItem = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: changeItem,
        currentIndex: _currentItem,
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
  }
}

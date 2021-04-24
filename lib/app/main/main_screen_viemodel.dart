import 'package:flutter/cupertino.dart';

import '../../core/viewmodel/base_viewmodel.dart';
import '../routes.dart';

class MainScreenViewModel extends BaseViewmodel {
  int _currentItem = 0;

  List<Widget> _pages = [ParkingSpots(), SavedSpots()];

  void changeItem(int page) {
    _currentItem = page;
    notifyListeners();
  }

  get currentPage => _currentItem;

  get pages => _pages;
}

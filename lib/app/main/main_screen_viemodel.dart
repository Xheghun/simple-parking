import 'package:simple_parking/core/viewmodel/base_viewmodel.dart';

class MainScreenViewModel extends BaseViewmodel {
  int _currentItem = 0;

  void changeItem(int page) {
    _currentItem = page;
    notifyListeners();
  }

  get currentPage => _currentItem;
}

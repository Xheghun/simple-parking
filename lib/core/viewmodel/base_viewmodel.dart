import 'package:flutter/widgets.dart';

import '../enum/view_state.dart';

class BaseViewmodel with ChangeNotifier {
  ViewState _state = ViewState.Idle;

  void changeState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  get state => _state;

  bool isBusy() => _state == ViewState.Busy;
}

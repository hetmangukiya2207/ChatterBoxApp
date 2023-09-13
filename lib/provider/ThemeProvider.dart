import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkView = false;

  changeTheme() {
    isDarkView = !isDarkView;
    notifyListeners();
  }
}

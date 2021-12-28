import 'package:flutter/material.dart';

class ThemeChange with ChangeNotifier {
  ThemeData _themeData;

  ThemeChange(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
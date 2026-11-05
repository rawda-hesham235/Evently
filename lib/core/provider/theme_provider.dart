import 'package:evently/core/colors/app_theme_color.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  AppThemeColor colors = LightColor();
  ThemeMode themeMode = ThemeMode.light;

  changeTheme(ThemeMode mode) {
    themeMode = mode;
    if (mode == ThemeMode.dark) {
      colors = DarkColor();
    } else {
      colors = LightColor();
    }
    notifyListeners();
  }
}

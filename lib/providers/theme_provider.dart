import "package:flutter/material.dart";
import "package:flutter_example/theme/app_theme.dart";
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  // dark mode statusune erişmek için.
  bool get isDarkMode => _isDarkMode;
  ThemeData get currentTheme => _isDarkMode ? AppTheme.dark : AppTheme.light;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
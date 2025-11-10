import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ViewModel для управления темой приложения
class ThemeViewModel extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  final SharedPreferences _prefs;

  ThemeMode _themeMode = ThemeMode.light;

  ThemeViewModel(this._prefs) {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Загрузить сохраненную тему
  void _loadTheme() {
    final isDark = _prefs.getBool(_themeKey) ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  /// Переключить тему
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _prefs.setBool(_themeKey, _themeMode == ThemeMode.dark);
    notifyListeners();
  }

  /// Установить конкретную тему
  Future<void> setTheme(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      await _prefs.setBool(_themeKey, mode == ThemeMode.dark);
      notifyListeners();
    }
  }
}


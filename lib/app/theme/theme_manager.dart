import 'package:eat_smart/app/theme/theme_storage_manage.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode getThemeMode() => _themeMode;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      // print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'system';
      if (themeMode == 'dark') {
        _themeMode = ThemeMode.dark;
      } else if (themeMode == 'system') {
        // print('setting dark theme');
        _themeMode = ThemeMode.system;
      } else {
        _themeMode = ThemeMode.light;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeMode = ThemeMode.dark;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeMode = ThemeMode.light;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  void setSystemMode() async {
    _themeMode = ThemeMode.system;
    StorageManager.saveData('themeMode', 'system');
    notifyListeners();
  }
}

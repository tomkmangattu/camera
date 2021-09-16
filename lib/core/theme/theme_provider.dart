import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:notes/core/theme/theme_data.dart';

class ThemeChanger extends ChangeNotifier {
  AppTheme _appTheme;

  ThemeChanger(this._appTheme);

  AppTheme get getAppTheme {
    return _appTheme;
  }

  void changeAppTheme({required bool isDarkTheme}) {
    final AppTheme appTheme = isDarkTheme ? AppTheme.light : AppTheme.dark;
    _appTheme = appTheme;
    notifyListeners();

    // write theme to db
    _writeThemetoDb(isDarkTheme: isDarkTheme);
  }

  void _writeThemetoDb({required bool isDarkTheme}) {
    final box = Hive.box('settings');
    box.put('darkMode', !isDarkTheme);
  }
}

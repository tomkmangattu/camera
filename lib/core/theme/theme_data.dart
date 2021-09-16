import 'package:flutter/material.dart';

import 'colors.dart';

enum AppTheme {
  dark,
  light,
}

Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: blue600,
    accentColor: blue600,
    fontFamily: 'Nunito',
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: teal900,
    accentColor: teal900,
    fontFamily: 'Nunito',
  ),
};

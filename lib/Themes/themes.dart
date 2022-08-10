import 'package:flutter/material.dart';
import 'package:notes_app/Constants/constants.dart';

class AppThemes {
  static ThemeMode themeMode = ThemeMode.system;
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppConstants.appPrimaryColor,
    primarySwatch: Colors.teal,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.appBgColor,
        foregroundColor: AppConstants.appPrimaryColor,
        elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppConstants.appBgColor,
      selectedItemColor: AppConstants.appPrimaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppConstants.appPrimaryColor,
      foregroundColor: AppConstants.appBgColor,
    ),
    scaffoldBackgroundColor: AppConstants.appBgColor,
    cardTheme: const CardTheme(color: AppConstants.appBgColor),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w700)),
    brightness: Brightness.light,
    highlightColor: Colors.transparent,
    splashFactory: InkRipple.splashFactory,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
      accentColor: Colors.teal,
      brightness: Brightness.light,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppConstants.appPrimaryColor,
    primarySwatch: Colors.teal,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.appBgDarkColor,
        foregroundColor: AppConstants.appPrimaryColor,
        elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppConstants.appBgDarkColor,
      selectedItemColor: AppConstants.appPrimaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppConstants.appBgDarkColor,
      foregroundColor: AppConstants.appPrimaryColor,
    ),
    scaffoldBackgroundColor: AppConstants.appBgDarkColorAlt,
    cardTheme: const CardTheme(color: AppConstants.appBgDarkColor),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w700)),
    brightness: Brightness.dark,
    highlightColor: Colors.transparent,
    splashFactory: InkRipple.splashFactory,
    colorScheme: ColorScheme.fromSwatch(
      primaryColorDark: AppConstants.appPrimaryColor,
      primarySwatch: Colors.teal,
      accentColor: Colors.teal,
      brightness: Brightness.dark,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:notes_app/Constants/app_colors.dart';

class AppThemes {
  static ThemeMode themeMode = ThemeMode.system;
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.appPrimaryColor,
    primarySwatch: Colors.teal,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBgColor,
        foregroundColor: AppColors.appPrimaryColor,
        elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.appBgColor,
      selectedItemColor: AppColors.appPrimaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.appPrimaryColor,
      foregroundColor: AppColors.appBgColor,
    ),
    scaffoldBackgroundColor: AppColors.appBgColor,
    cardTheme: const CardTheme(color: AppColors.appBgColor),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.grey,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyText2: TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
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
    primaryColor: AppColors.appPrimaryColor,
    primarySwatch: Colors.teal,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBgDarkColor,
        foregroundColor: AppColors.appPrimaryColor,
        elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.appBgDarkColor,
      selectedItemColor: AppColors.appPrimaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.appBgDarkColor,
      foregroundColor: AppColors.appPrimaryColor,
    ),
    scaffoldBackgroundColor: AppColors.appBgDarkColorAlt,
    cardTheme: const CardTheme(color: AppColors.appBgDarkColor),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.grey,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyText2: TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    brightness: Brightness.dark,
    highlightColor: Colors.transparent,
    splashFactory: InkRipple.splashFactory,
    colorScheme: ColorScheme.fromSwatch(
      primaryColorDark: AppColors.appPrimaryColor,
      primarySwatch: Colors.teal,
      accentColor: Colors.teal,
      brightness: Brightness.dark,
    ),
  );
}

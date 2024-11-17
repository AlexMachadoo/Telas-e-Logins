import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: AppTextStyles.appBarTitle,
      iconTheme: IconThemeData(color: AppColors.lightIcon),
    ),
    textTheme: AppTextStyles.lightTextTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: AppTextStyles.appBarTitle,
      iconTheme: IconThemeData(color: AppColors.darkIcon),
    ),
    textTheme: AppTextStyles.darkTextTheme,
  );
}

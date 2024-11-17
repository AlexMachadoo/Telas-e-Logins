import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light, 
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple,
      foregroundColor: const Color.fromARGB(255, 48, 0, 0),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.grey[600]),
      titleLarge: TextStyle(color: const Color.fromARGB(255, 54, 0, 0)),
    ),
    iconTheme: IconThemeData(color: const Color.fromARGB(255, 12, 0, 54)),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.deepPurple,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark, // Garantir que o brilho seja escuro
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: const Color.fromARGB(255, 59, 0, 0),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
    ),
  );
}

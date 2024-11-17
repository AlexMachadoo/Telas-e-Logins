import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 27, 26, 26),
  );

  static TextTheme lightTextTheme = TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: const Color.fromARGB(179, 18, 0, 117)),
    bodyMedium: TextStyle(fontSize: 14, color: const Color.fromARGB(153, 23, 0, 107)),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 0, 0, 0),
    ),
  );
}

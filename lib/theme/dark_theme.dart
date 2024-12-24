import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.grey[900],
      textTheme: TextTheme(
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      )
    );
  }
}
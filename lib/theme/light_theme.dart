import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.lightBlueAccent,
      scaffoldBackgroundColor: Colors.white,
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
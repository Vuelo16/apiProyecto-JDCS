import 'package:flutter/material.dart';

class AppTheme{
  static const Color primary = Color.fromARGB(255, 4, 62, 109);
  static const Color secundary = Colors.lightBlue;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: const Color.fromARGB(255, 43, 61, 163),
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation : 0
    ),

    textTheme: const TextTheme(bodyMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secundary
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),
          topRight: Radius.circular(10))
        )
    )
  );
}
import 'package:flutter/material.dart';

class AppTheme {
  static Color get primary => const Color(0xFF3B72FF);
  static Color get background => const Color(0xFFF3F6FD);
  static Color get accent => const Color(0xFF1E62D0);

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: const TextTheme(
   //   headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //  bodyText2: TextStyle(fontSize: 14),
    ),
  );
}

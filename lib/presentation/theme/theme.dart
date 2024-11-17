import 'package:flutter/material.dart';


class AppColors {
  static Color mainColor = const Color(0xFF4682A9);
}



ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: 'Poppins',

  textTheme: const TextTheme(

    bodySmall: TextStyle(fontWeight: FontWeight.w300 ),
    bodyMedium: TextStyle(fontWeight: FontWeight.w300 ),
    bodyLarge: TextStyle(fontWeight: FontWeight.w300 ),

    headlineSmall:  TextStyle(fontWeight: FontWeight.w700 ),
    headlineMedium: TextStyle(fontWeight: FontWeight.w700 ),
    headlineLarge: TextStyle(fontWeight: FontWeight.w700 ),

    displaySmall: TextStyle(fontWeight: FontWeight.w700 ),
    displayMedium: TextStyle(fontWeight: FontWeight.w700 ),
    displayLarge: TextStyle(fontWeight: FontWeight.w700 ),

  )



);


ThemeData darkTheme = ThemeData(
  primaryColor: Colors.red,
  fontFamily: 'Poppins',


);
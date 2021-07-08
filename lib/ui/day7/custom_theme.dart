import 'package:flutter/material.dart';


ThemeData buildAppTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      brightness: Brightness.light,
      accentColor: Colors.amber,
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.grey,
      backgroundColor: Colors.amber,
      textTheme: TextTheme(
        bodyText2: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "Sriracha"),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontFamily: "Sriracha",
              fontSize: 40,
            ),
            primary: Colors.purple,
          )
      )
  );
}

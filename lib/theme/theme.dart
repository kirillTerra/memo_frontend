import 'package:flutter/material.dart';

// Создание пользовательской цветовой палитры
Map<int, Color> color = {
  50: Color.fromRGBO(162, 197, 250, .1),
  100: Color.fromRGBO(162, 197, 250, .2),
  200: Color.fromRGBO(162, 197, 250, .3),
  300: Color.fromRGBO(162, 197, 250, .4),
  400: Color.fromRGBO(162, 197, 250, .5),
  500: Color.fromRGBO(162, 197, 250, .6),
  600: Color.fromRGBO(162, 197, 250, .7),
  700: Color.fromRGBO(162, 197, 250, .8),
  800: Color.fromRGBO(162, 197, 250, .9),
  900: Color.fromRGBO(162, 197, 250, 1),
};

MaterialColor customColor = MaterialColor(0xFFA2C5FA, color);

final lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFF8F8F8), // Светлый фон
  primarySwatch: customColor, // Использование пользовательской цветовой палитры
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black), // Черные иконки в AppBar
    elevation: 0,
    backgroundColor: Color(0xFFF8F8F8), // Светлый фон для AppBar
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
  listTileTheme: const ListTileThemeData(iconColor: Colors.black),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.black.withOpacity(0.6),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),
);

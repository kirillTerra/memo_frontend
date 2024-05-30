import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFF8F8F8), // Светлый фон
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black), // Черные иконки в AppBar
    elevation: 0,
    backgroundColor: Color.fromARGB(255, 24, 176, 227), // Светлый фон для AppBar
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
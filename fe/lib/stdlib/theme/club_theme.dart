import 'package:flutter/material.dart';

ThemeData clubTheme = ThemeData(
    primaryColorBrightness: Brightness.light,
    textTheme: const TextTheme(
        caption: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    )),
    primarySwatch: Colors.deepOrange,
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)));

import 'package:flutter/material.dart';

ThemeData clubTheme = ThemeData(
    primaryColorBrightness: Brightness.light,
    textTheme: const TextTheme(
        caption: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    )),
    primaryColor: const Color(0xffff5e4d),
    primarySwatch: Colors.red,
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)));

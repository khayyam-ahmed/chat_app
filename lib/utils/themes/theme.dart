import 'package:chat_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._(); // Making this a private constructor beacause we don't want to instantiate this class.
  // Having a private constructor means all its members are static.

  static ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: TColors.lightModeSeedColor),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: TColors.darkModeSeedColor),
  );
}

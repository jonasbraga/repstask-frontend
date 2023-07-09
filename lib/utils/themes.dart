import 'package:flutter/material.dart';
import 'package:reptask/utils/primary_color.dart';

class MyThemes {
  static final primary = primaryColor;
  static final primaryShade = primaryColor.shade300;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryShade,
    colorScheme: ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryShade,
    colorScheme: ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
  );
}

import 'package:flutter/material.dart';

Color color = const Color.fromRGBO(70, 4, 138, 1);

final Map<int, Color> shades = {
  50: const Color.fromRGBO(70, 4, 138, 1),
  100: const Color.fromRGBO(70, 4, 138, 1),
  200: const Color.fromRGBO(70, 4, 138, 1),
  300: const Color.fromRGBO(70, 4, 138, 1),
  400: const Color.fromRGBO(70, 4, 138, 1),
  500: const Color.fromRGBO(70, 4, 138, 1),
  600: const Color.fromRGBO(70, 4, 138, 1),
  700: const Color.fromRGBO(70, 4, 138, 1),
  800: const Color.fromRGBO(70, 4, 138, 1),
  900: const Color.fromRGBO(70, 4, 138, 1),
};

final primaryColor = MaterialColor(color.value, shades);

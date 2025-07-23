import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white70,
    onSurface: Colors.black,
    primary: const Color.fromARGB(255, 3, 37, 65),
    onPrimary: Colors.white,
  ),
);

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.black26,
    primary: Colors.black,
    onPrimary: Colors.white,
  ),
);

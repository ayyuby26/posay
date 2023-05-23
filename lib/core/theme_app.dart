import 'package:flutter/material.dart';
import 'package:posay/color.dart';

class ThemeApp {
  static ThemeData get base {
    return ThemeData(
      fontFamily: 'Lato',
      colorScheme: const ColorScheme.light(primary: color2),
      useMaterial3: true,
      scaffoldBackgroundColor: color1,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.red,
        surfaceTintColor: Colors.blue,
      ),
    );
  }
}
  
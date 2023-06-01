import 'package:flutter/material.dart';
import 'package:posay/shared/i_colors.dart';

class ITheme {
  final IColor _color;

  ITheme(this._color);

  ThemeData get base {
    return ThemeData(
      fontFamily: 'Lato',
      colorScheme: ColorScheme.light(primary: _color.primary),
      useMaterial3: true,
      scaffoldBackgroundColor: _color.background,
    );
  }
}



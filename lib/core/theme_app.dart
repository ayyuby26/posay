import 'package:flutter/material.dart';
import 'package:posay/shared/i_colors.dart';

class ITheme {
  ITheme();

  ThemeData get base {
    return ThemeData(
      fontFamily: 'Lato',
      colorScheme: ColorScheme.light(primary: IColor.primary),
      useMaterial3: true,
      scaffoldBackgroundColor: IColor.background,
    );
  }
}

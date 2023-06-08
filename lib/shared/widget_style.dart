import 'package:flutter/material.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/i_colors.dart';

OutlineInputBorder get outlineInputBorder {
  return OutlineInputBorder(
    borderRadius: Const.radiusCircular8,
    borderSide: borderSide,
  );
}

BorderSide get borderSide {
  return BorderSide(color: IColor.border);
}

OutlineInputBorder get borderStyleLeft {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
    borderSide: borderSide,
  );
}

ButtonStyle get textBtnStyle {
  return TextButton.styleFrom(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      side: borderSide,
      borderRadius: const BorderRadius.horizontal(
        right: Radius.circular(8),
      ),
    ),
  );
}

ButtonStyle get buttonStylePrimary {
  return TextButton.styleFrom(
    backgroundColor: IColor.primary,
    shape: Const.roundedCircular8,
    fixedSize: Const.sizeFullWidthH55,
  );
}

ButtonStyle get buttonStyleCancel {
  return buttonStylePrimary.copyWith(
    backgroundColor: MaterialStatePropertyAll(Colors.red[700]),
  );
}

TextStyle get textStyle {
  return const TextStyle(color: Colors.white);
}

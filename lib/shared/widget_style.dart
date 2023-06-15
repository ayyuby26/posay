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

Widget iconic(double size) {
  return Stack(
    children: [
      Icon(Icons.circle, size: size),
      SizedBox(
        width: size,
        height: size,
        child: Icon(
          Icons.person_4_rounded,
          size: size / 2.59,
          color: Colors.white,
        ),
      ),
    ],
  );
}

Widget get background {
  return Container(
    height: Const.screenSize.height / 1.8,
    foregroundDecoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          IColor.background.withOpacity(.0),
          IColor.background.withOpacity(.9),
        ],
      ),
    ),
    child: Image.asset(
      "assets/background.png",
      fit: BoxFit.cover,
    ),
  );
}

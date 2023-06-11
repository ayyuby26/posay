import 'package:flutter/material.dart';
import 'package:posay/shared/extension.dart';

class Helper {
  static double dotRemover(String number, BuildContext context) {
    final x = context.isEn ? number : number.replaceAll(".", "");
    return double.parse(x);
  }

  static widgetLoaded(Function() x) {
    WidgetsBinding.instance.addPostFrameCallback((_) => x());
  }
}

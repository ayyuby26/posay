import 'package:flutter/material.dart';
import 'package:posay/shared/extension.dart';

class Helper {
  static String currencyDoubleToStr(String number, String currency) {
    return currency == "usd"
        ? "${number}0"
        : addThousandsSeparator(number.split(".")[0]);
  }

  static double dotRemover(String number, BuildContext context) {
    final x = context.isEn ? number : number.replaceAll(".", "");
    return double.parse(x);
  }

  static widgetLoaded(Function() x) {
    WidgetsBinding.instance.addPostFrameCallback((_) => x());
  }

  static String addThousandsSeparator(String input) {
    String reversedInput = input.split('').reversed.join('');
    String output = '';
    int count = 0;

    for (int i = 0; i < reversedInput.length; i++) {
      output += reversedInput[i];
      count++;

      if (count % 3 == 0 && i != reversedInput.length - 1) {
        output += '.';
      }
    }

    return output.split('').reversed.join('');
  }
}

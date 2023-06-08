import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:posay/shared/extension.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final BuildContext context;

  CurrencyInputFormatter(this.context);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.currency(
      locale: context.isEn ? 'en_US' : 'id_ID',
      decimalDigits: context.isEn ? 2 : 0,
      symbol: "",
    );

    String newText = formatter.format(context.isEn ? value / 100 : value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

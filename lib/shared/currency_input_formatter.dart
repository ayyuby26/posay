import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:posay/shared/extension.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final BuildContext context;
  final String currency;

  CurrencyInputFormatter(this.context, this.currency);

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
      locale: currency.isEmpty
          ? context.isEn
              ? 'en_US'
              : 'id_ID'
          : currency == "usd"
              ? 'en_US'
              : 'id_ID',
      decimalDigits: currency.isEmpty
          ? context.isEn
              ? 2
              : 0
          : currency == "usd"
              ? 2
              : 0,
      symbol: "",
    );

    String newText = formatter.format(
      currency.isEmpty
          ? context.isEn
              ? value / 100
              : value
          : currency == "usd"
              ? value / 100
              : value,
    );

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

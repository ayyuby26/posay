import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posay/shared/currency_input_formatter.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';

class PriceBox extends StatelessWidget {
  final String prefixText;
  final TextEditingController priceController;
  final String currency;

  const PriceBox(
    this.priceController,
    this.prefixText,
    this.currency, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CurrencyInputFormatter(context, currency),
        ],
        controller: priceController,
        decoration: InputDecoration(
          prefixText: prefixText,
          contentPadding: Const.edgesSymmetricV8H16,
          labelText: context.tr.price,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

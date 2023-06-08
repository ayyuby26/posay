import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/currency_input_formatter.dart';
import 'package:posay/shared/extension.dart';

class PriceBox extends StatelessWidget {
  final TextEditingController priceController;
  const PriceBox(this.priceController, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyInputFormatter(context),
      ],
      controller: priceController,
      decoration: InputDecoration(
        prefixIcon: prefixIcon(context),
        contentPadding: Const.edgesAll16,
        labelText: "Price",
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  SizedBox prefixIcon(BuildContext context) {
    return SizedBox(
      width: 1,
      child: Center(
        child: Text(context.isEn ? "\$" : "Rp"),
      ),
    );
  }
}

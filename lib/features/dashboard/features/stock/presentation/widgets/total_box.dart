import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';

class TotalBox extends StatelessWidget {
  final TextEditingController priceController;
  const TotalBox(this.priceController, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: priceController,
      decoration: InputDecoration(
        contentPadding: Const.edgesSymmetricV8H16,
        labelText: "Total",
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

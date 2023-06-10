import 'package:flutter/material.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';

class UnitBox extends StatelessWidget {
  final TextEditingController priceController;
  const UnitBox(this.priceController, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: priceController,
      decoration: InputDecoration(
        contentPadding: Const.edgesAll16,
        labelText: "Unit",
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

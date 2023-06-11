import 'package:flutter/material.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';

class UnitBox extends StatelessWidget {
  final TextEditingController priceController;
  const UnitBox(this.priceController, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: priceController,
      decoration: InputDecoration(
        contentPadding: Const.edgesSymmetricV8H16,
        labelText: context.tr.unit,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

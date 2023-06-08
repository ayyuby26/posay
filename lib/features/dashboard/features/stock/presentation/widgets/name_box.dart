import 'package:flutter/material.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';

class NameBox extends StatelessWidget {
  final TextEditingController nameController;
  const NameBox(this.nameController, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        contentPadding: Const.edgesAll16,
        labelText: "Name",
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

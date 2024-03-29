import 'package:flutter/material.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';

class NameBox extends StatelessWidget {
  final TextEditingController nameController;
  const NameBox(this.nameController, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameController,
      decoration: InputDecoration(
        contentPadding: Const.edgesSymmetricV8H16,
        labelText: context.tr.name,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

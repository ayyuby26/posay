import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';

class CodeBox extends StatelessWidget {
  final TextEditingController codeController;
  const CodeBox(this.codeController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            inputFormatters: inputFormatters,
            controller: codeController,
            decoration: InputDecoration(
              contentPadding: Const.edgesAll16,
              labelText: "Code",
              focusedBorder: borderStyleLeft,
              enabledBorder: borderStyleLeft,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 55,
          child: TextButton(
            style: textBtnStyle,
            onPressed: () async => onPress(context),
            child: const Icon(Icons.qr_code_scanner),
          ),
        ),
      ],
    );
  }

  List<FilteringTextInputFormatter> get inputFormatters {
    return [
      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
    ];
  }

  void onPress(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      context.tr.cancel,
      true,
      ScanMode.BARCODE,
    );
    codeController.text = barcodeScanRes;
  }
}

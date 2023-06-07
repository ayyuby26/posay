import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/pop_up.dart';
import 'package:posay/shared/print.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Add Transaction",
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  "#ff6666",
                  context.tr.cancel,
                  true,
                  ScanMode.BARCODE,
                );
                // ignore: use_build_context_synchronously
                PopUp.ok(
                  title: "Result",
                  content: barcodeScanRes,
                  context: context,
                );
                Print.green(barcodeScanRes);
              },
              child: const Text("Scan"),
            ),
            const Text("TRANSACTION PAGE"),
          ],
        ),
      ),
    );
  }
}

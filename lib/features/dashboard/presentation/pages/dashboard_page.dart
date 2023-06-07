import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/pop_up.dart';
import 'package:posay/shared/print.dart';

class DashboardPage extends StatefulWidget {
  static String get path => "/";
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late BuildContext parentContext;
  @override
  void didChangeDependencies() {
    parentContext = context;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  "#ff6666",
                  context.tr.cancel,
                  true,
                  ScanMode.BARCODE,
                );
                context.okPopUp(title: "Result", content: barcodeScanRes);
                Print.green(barcodeScanRes);
              },
              child: const Text("Scan")),
          const Text("DASHBOARD"),
        ],
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                PopUp.okCancel(
                  ForegroundColorOk: Colors.red,
                  context: context,
                  title: parentContext.tr.logoutConfirmTitle,
                  content: parentContext.tr.logoutConfirmContent,
                  titleOk: parentContext.tr.logout,
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogout(context));
                  },
                );
              },
              icon: const Icon(
                Icons.output,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}

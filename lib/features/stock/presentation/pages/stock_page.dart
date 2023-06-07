import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => StockPageState();
}

class StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Stock Page"),
      ),
    );
  }
}

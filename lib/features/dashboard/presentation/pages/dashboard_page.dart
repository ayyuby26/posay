import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  static String get path => "/";
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("DASHBOARD"),
      appBar: AppBar(),
    );
  }
}

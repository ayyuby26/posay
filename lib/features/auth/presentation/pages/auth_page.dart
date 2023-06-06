import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  static String get path => "/auth";

  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("AUTH PAGE")),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';

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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Center(child: Text("Konfirmasi keluar")),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Apakah anda yakin ingin keluar?"),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: context.pop,
                          child: const Text("Batal"),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(AuthLogout(context));
                          },
                          child: const Text(
                            "Keluar",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
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

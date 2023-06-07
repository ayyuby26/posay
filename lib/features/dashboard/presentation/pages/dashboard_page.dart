import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/pop_up.dart';

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
      body: const Text("DASHBOARD"),
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

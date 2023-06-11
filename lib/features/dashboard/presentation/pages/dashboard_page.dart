import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/dashboard/features/report/presentation/pages/report_page.dart';
import 'package:posay/features/dashboard/features/setting/presentation/pages/setting_page.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/stock_page.dart';
import 'package:posay/features/dashboard/features/transaction/presentation/pages/transaction_page.dart';
import 'package:posay/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:posay/shared/extension.dart';

class DashboardPage extends StatelessWidget {
  static String get path => "/";
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: const _DashboardPage(),
    );
  }
}

class _DashboardPage extends StatefulWidget {
  const _DashboardPage();

  @override
  State<_DashboardPage> createState() => __DashboardPageState();
}

class __DashboardPageState extends State<_DashboardPage> {
  final pages = [
    const ReportPage(),
    const TransactionPage(),
    const StockPage(),
    const SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.index],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.bar_chart_rounded),
                label: context.tr.report,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.compare_arrows_rounded),
                label: context.tr.transaction,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.inventory,
                  size: 20,
                ),
                label: context.tr.stock,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: context.tr.setting,
              ),
            ],
            onTap: (value) {
              context.read<DashboardBloc>().add(DashboardIndexEvent(value));
            },
            currentIndex: state.index,
          ),
        );
      },
    );
  }
}

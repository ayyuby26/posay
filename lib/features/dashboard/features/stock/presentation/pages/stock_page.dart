import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/add_stock_page.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/search_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/stock_item.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/unfocus.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => StockPageState();
}

class StockPageState extends State<StockPage> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Unfocus(
        child: Column(
          children: [
            SizedBox(height: context.appBarHeight),
            SearchBox(),
            Const.height8,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 2));
                },
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      StockItem(),
                      SizedBox(height: 72),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Stock",
        onPressed: () => context.push(AddStockPage.path),
        child: const Icon(Icons.add),
      ),
    );
  }
}

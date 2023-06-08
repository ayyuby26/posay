import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/add_stock_page.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Stock",
        onPressed: () {
          context.push(AddStockPage.path);
        },
        child: const Icon(Icons.add),
      ),
      body: Unfocus(
        child: Column(
          children: [
            SizedBox(height: context.appBarHeight),
            Padding(
              padding: Const.edgesSymmetricV8H16,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: IColor.tertiary,
                  ),
                  contentPadding: Const.edgesAll16,
                  hintText: context.tr.finish,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular16,
                    borderSide: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular16,
                    borderSide: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 2));
                },
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      _Item(),
                      SizedBox(height: 72),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: Const.edgesAll16,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Const.radiusCircular8,
        border: Border.all(
          color: IColor.tertiary.withOpacity(.3),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Jahe Kencur",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Text(
                "3 pcs",
                // style: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 18,
                // ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rp 3.000"),
              Text(
                "EXP: 28 Jan 2020",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

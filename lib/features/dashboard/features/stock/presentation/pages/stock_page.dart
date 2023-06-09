import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/stock_manager_page.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/search_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/stock_item.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/unfocus.dart';
import 'package:posay/shared/widget_style.dart';

import '../bloc/stock_bloc.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => StockPageState();
}

class StockPageState extends State<StockPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    context.read<StockBloc>().add(StockGetData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Unfocus(
        child: Column(
          children: [
            SizedBox(height: context.appBarHeight),
            BlocBuilder<StockBloc, StockState>(
              builder: (context, state) {
                return SearchBox(enabled: state.stockList.isNotEmpty);
              },
            ),
            Const.height8,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  context.read<StockBloc>().add(StockGetData());
                  return Future.value();
                },
                child: BlocBuilder<StockBloc, StockState>(
                  builder: (context, state) {
                    if (state is StockDataError) {
                      return Center(
                          child: Padding(
                        padding: Const.edgesAll16,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(state.message),
                            Const.height16,
                            TextButton(
                                style: buttonStylePrimary,
                                onPressed: () {
                                  context.read<StockBloc>().add(StockGetData());
                                },
                                child: Text(
                                  "Coba Lagi",
                                  style: textStyle,
                                ))
                          ],
                        ),
                      ));
                    }
                    if (state is StockDataLoading) {
                      return Container(
                        color: IColor.background,
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child:
                            const Center(child: CupertinoActivityIndicator()),
                      );
                    }
                    if (state is StockDataSuccess || state is StockUpdated) {
                      return SingleChildScrollView(
                        child: Column(
                          children:
                              state.stockList.map((e) => StockItem(e)).toList(),
                          // [
                          //   Container(
                          //     color: Colors.red,
                          //     width: 100,
                          //     height: 900,
                          //   )
                          // ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Stock",
        onPressed: () => context.push(StockManagerPage.path),
        child: const Icon(Icons.add),
      ),
    );
  }
}

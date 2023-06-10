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
  final _controller = ScrollController();

  @override
  void initState() {
    final stockEmpty = context.read<StockBloc>().state.stockList.isEmpty;
    if (stockEmpty) context.read<StockBloc>().add(StockGetData());

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        final state = context.read<StockBloc>().state;
        if (!isTop && state is! StockLastPage) {
          context.read<StockBloc>().add(StockNextPage());
        }
      }
    });
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
                    if (state.stockList.isNotEmpty) {
                      return SingleChildScrollView(
                        controller: _controller,
                        child: Column(
                          children:
                              state.stockList.map((e) => StockItem(e)).toList(),
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
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Stock",
        onPressed: () async {
          final newData = await context.push(StockManagerPage.path);
          if (newData is bool && newData) {
            Future.delayed(const Duration(milliseconds: 500), () {
              context.read<StockBloc>().add(StockGetData());
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

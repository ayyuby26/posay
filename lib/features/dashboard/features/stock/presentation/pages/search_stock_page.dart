import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/dashboard/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/search_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/stock_item.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/helper.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/unfocus.dart';
import 'package:posay/shared/widgets/failure_widget.dart';
import 'package:posay/shared/widgets/loading_widget.dart';

class SearchStockPage extends StatefulWidget {
  static String get path => "/searchStock";
  const SearchStockPage({super.key});

  @override
  State<SearchStockPage> createState() => _SearchStockPageState();
}

class _SearchStockPageState extends State<SearchStockPage> {
  StockBloc? stock;

  @override
  void initState() {
    Helper.widgetLoaded(() => stock = context.read<StockBloc>());
    super.initState();
  }

  @override
  void dispose() {
    stock?.add(StockSearchReset());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.searchPage),
      ),
      body: Unfocus(
          child: Column(
        children: [
          Const.height8,
          SearchBox(),
          Const.height8,
          Expanded(
            child: BlocBuilder<StockBloc, StockState>(
              builder: (context, state) {
                if (state.statusSearchStocks.isLoading) {
                  return const LoadingWidget();
                }
                if (state.statusSearchStocks.isFail) {
                  return FailureWidget(failure: state.failure);
                }
                if (state.statusSearchStocks.isSuccess) {
                  return _MainContent(state);
                }
                return welcomeMessage;
              },
            ),
          )
        ],
      )),
    );
  }

  Widget get welcomeMessage => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 90,
              color: IColor.secondary,
            ),
            Text(
              context.tr.findStockDesc,
              style: TextStyle(color: IColor.secondary),
            )
          ],
        ),
      );
}

class _MainContent extends StatelessWidget {
  final _scrollController = ScrollController();
  final StockState state;
  _MainContent(this.state);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return StockItem(state.stocks[index]);
      },
      itemCount: state.searchStocks.length,
      controller: _scrollController,
    );
  }

  Widget get bottomLoading => const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: CupertinoActivityIndicator(),
      );
}

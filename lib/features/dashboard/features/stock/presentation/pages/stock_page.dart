import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/dashboard/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/search_stock_page.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/stock_manager_page.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/search_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/stock_item.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/unfocus.dart';
import 'package:posay/shared/widgets/empty_stock_widget.dart';
import 'package:posay/shared/widgets/failure_widget.dart';
import 'package:posay/shared/widgets/loading_widget.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => StockPageState();
}

class StockPageState extends State<StockPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    final stock = context.read<StockBloc>();
    final stockEmpty = stock.state.stocks.isEmpty;
    if (stockEmpty) stock.add(StockGetData());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        stock.add(const StockChangeStateIsScrollableEvent(true));
      }
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop && !stock.state.hasReachedMax) {
          stock.add(const StockNextPage());
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Unfocus(
        child: Column(
          children: [
            context.appBarHeight,
            _search(context),
            Expanded(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: BlocBuilder<StockBloc, StockState>(
                  builder: builder,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: context.tr.stockAdd,
        onPressed: () async {
          context.push(StockManagerPage.pathEmpty);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _search(BuildContext context) {
    return Stack(
      children: [
        SearchBox(),
        GestureDetector(
          onTap: () {
            context.push(SearchStockPage.path);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 7, 16, 16),
            child: Container(
              height: 50,
              width: double.maxFinite,
              color: Colors.transparent,
              // color: const Color.fromARGB(42, 244, 67, 54),
            ),
          ),
        )
      ],
    );
  }

  Widget builder(BuildContext context, StockState state) {
    if (state.status.isFail) {
      FailureWidget(failure: state.failure);
    }

    if (state.status.isLoading) {
      return const LoadingWidget();
    }
    if (state.stocks.isNotEmpty) {
      return _MainContent(state, _scrollController);
    } else {
      return const EmptyStockWidget();
    }
  }

  void listener(BuildContext context, StockState state) {
    // autoScroll(state);
  }

  Future<void> onRefresh() {
    context.read<StockBloc>().add(StockGetData());
    return Future.value();
  }
}

class _MainContent extends StatelessWidget {
  final StockState state;
  final ScrollController scrollController;
  const _MainContent(this.state, this.scrollController);

  Widget get bottomLoading => const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: CupertinoActivityIndicator(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return state.hasReachedMax && (index + 1) == state.stocks.length
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 72),
                    child: StockItem(index, scrollController),
                  )
                : StockItem(index, scrollController);
          },
          itemCount: state.stocks.length,
          controller: scrollController,
        );
      },
    );
  }
}

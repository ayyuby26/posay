import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/add_stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/delete_stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/get_stock_list.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/next_page_stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/search_stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/update_stock.dart';
import 'package:posay/shared/action.dart';
import 'package:posay/shared/failure.dart';
import 'package:posay/shared/status.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final GetStockList _getStockList;
  final AddStock _addStock;
  final NextPageStock _nextPageStock;
  final SearchStock _searchStock;
  final DeleteStock _deleteStock;
  final UpdateStock _updateStock;

  StockBloc(
    this._updateStock,
    this._deleteStock,
    this._searchStock,
    this._getStockList,
    this._addStock,
    this._nextPageStock,
  ) : super(const StockState()) {
    on<StockUpdateEvent>(_stockUpdateEvent);
    on<StockUpdateExpired>(_stockUpdateExpired);
    on<StockGetData>(stockGetData);
    on<StockAddData>(_stockAddData);
    on<StockNextPage>(_stockNextPage);
    on<StockSearching>(_stockSearching);
    on<StockHasReachMaxReset>(_stockHasReachMaxReset);
    on<StockSearchReset>(_stockSearchReset);
    on<StockDelete>(_stockDelete);
    on<StockFillEvent>(_stockFillEvent);
    on<StockManagerResetEvent>(_stockManagerResetEvent);
    on<StockChangeStateIsScrollableEvent>(_stockChangeStateIsScrollableEvent);
  }

  _stockUpdateExpired(StockUpdateExpired event, Emitter<StockState> emit) {
    emit(state.copyWith(
      expired: event.expired,
      update: state.update + 1,
      statusManagerStock: Status.initial,
    ));
  }

  stockGetData(StockGetData event, Emitter<StockState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _getStockList.execute();
    result.fold(
      (l) => emit(state.copyWith(failure: l)),
      (r) => emit(state.copyWith(
        stocks: r,
        status: Status.success,
        hasReachedMax: false,
      )),
    );
  }

  _stockAddData(StockAddData event, Emitter<StockState> emit) async {
    emit(state.copyWith(
        statusManagerStock: Status.loading, action: ActionDo.add));

    final stock = Stock(
      name: event.name,
      code: event.code,
      total: event.total,
      unit: event.unit,
      price: event.price,
      stockIn: DateTime.now(),
      currency: event.currency,
      expired: state.expired,
      documentId: '',
    );

    final result = await _addStock.execute(stock);

    result.fold(
      (l) => emit(state.copyWith(
        failure: l,
        statusManagerStock: Status.error,
        action: ActionDo.add,
      )),
      (r) => emit(state.copyWith(
        statusManagerStock: Status.success,
        hasReachedMax: false,
        action: ActionDo.add,
      )),
    );
  }

  Future<void> _stockNextPage(
    StockNextPage event,
    Emitter<StockState> emit,
  ) async {
    if (state.hasReachedMax) return;
    emit(state.copyWith(nextPagestatus: Status.loading));
    final result = await _nextPageStock.execute(state.stocks.length);

    result.fold(
      (l) => emit(state.copyWith(failure: l, nextPagestatus: Status.error)),
      (r) {
        if (r.isEmpty) return emit(state.copyWith(hasReachedMax: true));
        emit(state.copyWith(
          stocks: List.of(state.stocks)..addAll(r),
          nextPagestatus: Status.success,
          hasReachedMax: event.isLast,
          isScrollAuto: event.isScrollAuto,
        ));
      },
    );
  }

  _stockSearching(StockSearching event, Emitter<StockState> emit) async {
    emit(state.copyWith(statusSearchStock: Status.loading));
    final result = await _searchStock.execute(event.search);
    result.fold(
      (l) => emit(state.copyWith(failure: l, statusSearchStock: Status.error)),
      (r) => emit(
          state.copyWith(searchStocks: r, statusSearchStock: Status.success)),
    );
  }

  _stockHasReachMaxReset(
      StockHasReachMaxReset event, Emitter<StockState> emit) {
    emit(state.copyWith(hasReachedMax: false));
  }

  _stockSearchReset(StockSearchReset event, Emitter<StockState> emit) {
    emit(state.copyWith(
      statusSearchStock: Status.initial,
      searchStocks: [],
      status: Status.initial,
    ));
  }

  _stockDelete(StockDelete event, Emitter<StockState> emit) async {
    emit(state.copyWith(
      statusManagerStock: Status.loading,
      action: ActionDo.delete,
    ));
    final result = await _deleteStock.execute(event.databaseId);
    result.fold(
      (l) => emit(state.copyWith(failure: l, statusManagerStock: Status.error)),
      (r) => emit(state.copyWith(statusManagerStock: Status.success)),
    );
  }

  _stockFillEvent(StockFillEvent event, Emitter<StockState> emit) {
    final stock = state.stocks.firstWhere((e) => e.documentId == event.docId);
    emit(state.copyWith(stock: stock));
  }

  _stockManagerResetEvent(
    StockManagerResetEvent event,
    Emitter<StockState> emit,
  ) {
    emit(state.copyWith(stock: null, statusManagerStock: Status.initial));
  }

  _stockChangeStateIsScrollableEvent(
    StockChangeStateIsScrollableEvent event,
    Emitter<StockState> emit,
  ) {
    emit(state.copyWith(isScrollable: event.val));
  }

  _stockUpdateEvent(
    StockUpdateEvent event,
    Emitter<StockState> emit,
  ) async {
    emit(state.copyWith(
      statusManagerStock: Status.loading,
      action: ActionDo.edit,
    ));
    final stockIn = state.stocks
        .firstWhere((e) => e.documentId == event.documentId)
        .stockIn;

    final stock = Stock(
      documentId: event.documentId,
      name: event.name,
      code: event.code,
      total: event.total,
      unit: event.unit,
      price: event.price,
      stockIn: stockIn,
      currency: event.currency,
    );

    final result = await _updateStock.execute(stock);
    result.fold(
      (l) => emit(state.copyWith(
        failure: l,
        statusManagerStock: Status.error,
        action: ActionDo.edit,
      )),
      (r) => emit(state.copyWith(
        statusManagerStock: Status.success,
        action: ActionDo.edit,
      )),
    );
  }
}

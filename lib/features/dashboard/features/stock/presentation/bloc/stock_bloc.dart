import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/get_stock_list.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  GetStockList getStockList;
  StockBloc(this.getStockList) : super(StockInitial()) {
    on<StockUpdateExpired>(_stockUpdateExpired);
    on<StockGetData>(_stockGetData);
  }

  FutureOr<void> _stockUpdateExpired(
    StockUpdateExpired event,
    Emitter<StockState> emit,
  ) {
    emit(StockUpdated(expired: event.expired, stockList: state.stockList));
  }

  FutureOr<void> _stockGetData(
    StockGetData event,
    Emitter<StockState> emit,
  ) async {
    final result = await getStockList.execute();
    emit(StockDataLoading());
    result.fold(
      (l) => emit(StockDataError(l.message)),
      (r) => emit(StockDataSuccess(r)),
    );
  }
}

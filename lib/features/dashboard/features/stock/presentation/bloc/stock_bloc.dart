import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posay/features/dashboard/features/stock/data/models/stock_model.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/add_stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/get_stock_list.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/next_page_stock.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final GetStockList getStockList;
  final AddStock _addStock;
  final NextPageStock _nextPageStock;

  StockBloc(
    this.getStockList,
    this._addStock,
    this._nextPageStock,
  ) : super(StockInitial()) {
    on<StockUpdateExpired>(_stockUpdateExpired);
    on<StockGetData>(stockGetData);
    on<StockAddData>(_stockAddData);
    on<StockNextPage>(_stockNextPage);
  }

  _stockUpdateExpired(StockUpdateExpired event, Emitter<StockState> emit) {
    emit(StockUpdated(
      expired: event.expired?.millisecondsSinceEpoch ?? -1,
      stockList: state.stockList,
    ));
  }

  stockGetData(StockGetData event, Emitter<StockState> emit) async {
    emit(StockDataLoading(state.stockList));
    final result = await getStockList.execute();
    result.fold(
      (l) => emit(StockDataError(l.message, state.stockList)),
      (r) => emit(StockDataSuccess(r)),
    );
  }

  _stockAddData(StockAddData event, Emitter<StockState> emit) async {
    emit(StockDataLoading(state.stockList));

    final stock = StockModel(
      name: event.name,
      code: event.code,
      total: event.total,
      unit: event.unit,
      price: event.price,
      stockIn: DateTime.now(),
      currency: event.currency,
      databaseId: '',
    );

    final result = await _addStock.execute(stock);

    result.fold(
      (l) => emit(StockDataError(l.message, state.stockList)),
      (r) => emit(StockAddSuccess(state.stockList)),
    );
  }

  _stockNextPage(StockNextPage event, Emitter<StockState> emit) async {
    emit(StockNextPageLoading(state.stockList));

    final currLength = state.stockList.length;
    final result = await _nextPageStock.execute(currLength);
    
    result.fold(
      (l) => emit(StockNextPageFailure(state.stockList)),
      (r) {
        if (r.isEmpty) {
          emit(StockLastPage(state.stockList, (state.update + 1)));
        } else {
          emit(StockNextPageSuccess(state.stockList..addAll(r)));
        }
      },
    );
  }
}

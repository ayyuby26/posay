part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  final List<Stock> stockList;
  final DateTime? expired;

  const StockState({this.expired, this.stockList = const []});

  @override
  List<Object?> get props => [expired, stockList];
}

class StockInitial extends StockState {}

class StockUpdated extends StockState {
  const StockUpdated({
    DateTime? expired,
    List<Stock> stockList = const [],
  }) : super(expired: expired, stockList: stockList);
}

class StockDataLoading extends StockState {}

class StockDataError extends StockState {
  final String message;

  const StockDataError(this.message);

  @override
  List<Object?> get props => [message];
}

class StockDataSuccess extends StockState {
  const StockDataSuccess(List<Stock> stockList) : super(stockList: stockList);
}

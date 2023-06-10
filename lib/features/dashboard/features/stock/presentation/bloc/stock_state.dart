part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  final List<Stock> stockList;
  final int expired;
  final int update;

  const StockState(
      {this.expired = -1, required this.stockList, this.update = -1});

  @override
  List<Object> get props => [expired, stockList, update];
}

class StockInitial extends StockState {
  StockInitial() : super(stockList: []);
}

class StockUpdated extends StockState {
  const StockUpdated({
    int expired = -1,
    List<Stock> stockList = const [],
  }) : super(expired: expired, stockList: stockList);
}

class StockDataLoading extends StockState {
  const StockDataLoading(List<Stock> stockList) : super(stockList: stockList);
}

class StockDataError extends StockState {
  final String message;

  const StockDataError(this.message, List<Stock> stockList)
      : super(stockList: stockList);
}

class StockDataSuccess extends StockState {
  const StockDataSuccess(List<Stock> stockList) : super(stockList: stockList);

  @override
  List<Object> get props => [stockList];
}

class StockAddSuccess extends StockState {
  const StockAddSuccess(List<Stock> stockList) : super(stockList: stockList);
}

class StockNextPageSuccess extends StockState {
  const StockNextPageSuccess(List<Stock> stockList)
      : super(stockList: stockList);
}

class StockNextPageFailure extends StockState {
  const StockNextPageFailure(List<Stock> stockList)
      : super(stockList: stockList);
}

class StockNextPageLoading extends StockState {
  const StockNextPageLoading(List<Stock> stockList)
      : super(stockList: stockList);
}

class StockLastPage extends StockState {
  const StockLastPage(
    List<Stock> stockList,
    int update,
  ) : super(
          stockList: stockList,
          update: update,
        );
}

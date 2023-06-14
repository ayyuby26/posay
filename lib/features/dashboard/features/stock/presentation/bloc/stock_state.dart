part of 'stock_bloc.dart';

final class StockState extends Equatable {
  final List<Stock> stocks;
  final List<Stock> searchStocks;
  final Failure failure;
  final Status status;
  final Status statusManagerStock;
  final ActionDo action;
  final Status statusSearchStocks;
  final Status nextPagestatus; 
  final int update;
  final bool addLoadingBottom;
  final bool hasReachedMax;
  final bool isScrollable;
  final bool isSearch;
  final bool isScrollAuto;
  final Stock? stock;
  final (int, int) indexPage;

  const StockState({
    this.indexPage = (-1, -1),
    this.stock,
    this.action = ActionDo.init,
    this.isScrollAuto = false,
    this.isSearch = false,
    this.isScrollable = false,
    this.hasReachedMax = false,
    this.failure = const InitFailure(""),
    this.status = Status.initial,
    this.statusManagerStock = Status.initial,
    this.statusSearchStocks = Status.initial,
    this.nextPagestatus = Status.initial,
    this.addLoadingBottom = false, 
    this.stocks = const [],
    this.searchStocks = const [],
    this.update = -1,
  });

  StockState copyWith({
    (int, int)? indexPage,
    ActionDo? action,
    bool? isScrollAuto,
    bool? isSearch,
    bool? isScrollable,
    bool? hasReachedMax,
    List<Stock>? stocks,
    Stock? stock,
    List<Stock>? searchStocks,
    Failure? failure,
    Status? status,
    Status? statusManagerStock,
    Status? statusSearchStock,
    Status? nextPagestatus, 
    int? update,
    bool? addLoadingBottom,
  }) {
    return StockState(
      indexPage: indexPage ?? this.indexPage,
      stock: stock,
      action: action ?? this.action,
      searchStocks: searchStocks ?? this.searchStocks,
      statusSearchStocks: statusSearchStock ?? statusSearchStocks,
      status: status ?? this.status,
      statusManagerStock: statusManagerStock ?? this.statusManagerStock,
      failure: failure ?? this.failure,
      stocks: stocks ?? this.stocks, 
      update: update ?? this.update,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      nextPagestatus: nextPagestatus ?? this.nextPagestatus,
      isScrollable: isScrollable ?? this.isScrollable,
      isSearch: isSearch ?? this.isSearch,
      isScrollAuto: isScrollAuto ?? this.isScrollAuto,
    );
  }

  @override
  List<Object?> get props => [
        indexPage,
        stock,
        action,
        failure,
        statusSearchStocks,
        statusManagerStock, 
        searchStocks,
        stocks,
        update,
        addLoadingBottom,
        status,
        hasReachedMax,
        nextPagestatus,
        isScrollable,
        isSearch,
        isScrollAuto
      ];
}

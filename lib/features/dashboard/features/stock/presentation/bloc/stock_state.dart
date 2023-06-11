part of 'stock_bloc.dart';

class StockState extends Equatable {
  final List<Stock> stocks;
  final List<Stock> searchStocks;
  final Failure failure;
  final Status status;
  final Status statusAddStock;
  final Status statusSearchStocks;
  final Status nextPagestatus;
  final DateTime? expired;
  final int update;
  final bool addLoadingBottom;
  final bool hasReachedMax;
  final bool isScrollable;
  final bool isSearch;
  final bool isScrollAuto;

  const StockState({
    this.isScrollAuto = false,
    this.isSearch = false,
    this.isScrollable = false,
    this.hasReachedMax = false,
    this.failure = const InitFailure(""),
    this.status = Status.initial,
    this.statusAddStock = Status.initial,
    this.statusSearchStocks = Status.initial,
    this.nextPagestatus = Status.initial,
    this.addLoadingBottom = false,
    this.expired,
    this.stocks = const [],
    this.searchStocks = const [],
    this.update = -1,
  });

  StockState copyWith({
    bool? isScrollAuto,
    bool? isSearch,
    bool? isScrollable,
    bool? hasReachedMax,
    List<Stock>? stocks,
    List<Stock>? searchStocks,
    Failure? failure,
    Status? status,
    Status? statusAddStock,
    Status? statusSearchStock,
    Status? nextPagestatus,
    DateTime? expired,
    int? update,
    bool? addLoadingBottom,
  }) {
    return StockState(
      searchStocks: searchStocks ?? this.searchStocks,
      statusSearchStocks: statusSearchStock ?? statusSearchStocks,
      status: status ?? this.status,
      statusAddStock: statusAddStock ?? this.statusAddStock,
      failure: failure ?? this.failure,
      stocks: stocks ?? this.stocks,
      expired: expired,
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
        failure,
        statusSearchStocks,
        statusAddStock,
        expired,
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

part of 'stock_bloc.dart';

sealed class StockEvent extends Equatable {
  final DateTime? expired;

  const StockEvent({this.expired});

  @override
  List<Object?> get props => [expired];
}

class StockUpdateExpired extends StockEvent {
  const StockUpdateExpired({DateTime? expired}) : super(expired: expired);
}

final class StockGetData extends StockEvent {}

class StockAddData extends StockEvent {
  final String code;
  final String name;
  final double price;
  final int total;
  final String currency;
  final String unit;

  const StockAddData({
    required this.code,
    required this.name,
    required this.price,
    required this.total,
    required this.currency,
    required this.unit,
    DateTime? expired,
  }) : super(expired: expired);

  @override
  List<Object?> get props => [
        code,
        name,
        price,
        total,
        currency,
        unit,
      ];
}

class StockNextPage extends StockEvent {
  final bool? isLast;
  final bool isScrollAuto;

  const StockNextPage({this.isLast, this.isScrollAuto = false});

  @override
  List<Object?> get props => [isLast, isScrollAuto];
}

class StockSearching extends StockEvent {
  final String search;

  const StockSearching(this.search);

  @override
  List<Object> get props => [search];
}

class StockAddLoadingBottom extends StockEvent {}

class StockHideLoadingBottom extends StockEvent {
  final bool isScrollable;

  const StockHideLoadingBottom(this.isScrollable);
  @override
  List<Object> get props => [isScrollable];
}

class StockHasReachMaxReset extends StockEvent {}

class StockSearchReset extends StockEvent {}

class StockDelete extends StockEvent {
  final String documentId;

  const StockDelete(this.documentId);

  @override
  List<Object> get props => [documentId];
}

class StockFillEvent extends StockEvent {
  final String docId;

  const StockFillEvent(this.docId);
}

class StockManagerResetEvent extends StockEvent {}

class StockChangeStateIsScrollableEvent extends StockEvent {
  final bool val;

  const StockChangeStateIsScrollableEvent(this.val);

  @override
  List<Object> get props => [val];
}

class StockUpdateEvent extends StockEvent {
  final String documentId;
  final String code;
  final String name;
  final double price;
  final int total;
  final String currency;
  final String unit;

  const StockUpdateEvent({
    required this.documentId,
    required this.code,
    required this.name,
    required this.price,
    required this.total,
    required this.currency,
    required this.unit,
    DateTime? expired,
  }) : super(expired: expired);

  @override
  List<Object?> get props => [
        documentId,
        code,
        name,
        price,
        total,
        currency,
        unit,
      ];
}

part of 'stock_bloc.dart';

abstract class StockEvent extends Equatable {
  final DateTime? expired;

  const StockEvent({this.expired});

  @override
  List<Object?> get props => [expired];
}

class StockUpdateExpired extends StockEvent {
  const StockUpdateExpired({DateTime? expired}) : super(expired: expired);
}

class StockGetData extends StockEvent {}

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

class StockNextPage extends StockEvent {}


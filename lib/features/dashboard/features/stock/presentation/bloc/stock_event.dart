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

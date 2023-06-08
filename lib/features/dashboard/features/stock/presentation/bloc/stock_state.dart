part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  final DateTime? expired;

  const StockState({this.expired});

  @override
  List<Object?> get props => [expired];
}

class StockInitial extends StockState {}

class StockUpdated extends StockState {
  const StockUpdated({DateTime? expired}) : super(expired: expired);
}

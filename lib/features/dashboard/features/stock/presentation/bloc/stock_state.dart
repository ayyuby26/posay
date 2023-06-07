part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  const StockState();  

  @override
  List<Object> get props => [];
}
class StockInitial extends StockState {}

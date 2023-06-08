import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc() : super(StockInitial()) {
    on<StockUpdateExpired>(_stockUpdateExpired);
  }

  FutureOr<void> _stockUpdateExpired(
    StockUpdateExpired event,
    Emitter<StockState> emit,
  ) {
    emit(StockUpdated(expired: event.expired));
  }
}

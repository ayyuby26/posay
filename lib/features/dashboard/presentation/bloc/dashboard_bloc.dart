import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardIndexEvent>(_dashboardIndexEvent);
  }

  FutureOr<void> _dashboardIndexEvent(
    DashboardIndexEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(DashboardIndexState(event.index));
  }
}

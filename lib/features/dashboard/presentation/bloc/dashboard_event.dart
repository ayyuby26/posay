part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardIndexEvent extends DashboardEvent {
  final int index;

  const DashboardIndexEvent(this.index);
  
  @override
  List<Object> get props => [index];
}

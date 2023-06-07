part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  final int index;
  const DashboardState({this.index = 0});

  @override
  List<Object> get props => [index];
}

class DashboardInitial extends DashboardState {}

class DashboardIndexState extends DashboardState {
  const DashboardIndexState(index) : super(index: index);
}

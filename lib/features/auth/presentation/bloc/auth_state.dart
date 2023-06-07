part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final bool isShow;
  const AuthState({this.isShow = false});

  @override
  List<Object> get props => [isShow];
}

class AuthInitial extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLogoutSuccess extends AuthState {}

class AuthShowPass extends AuthState {
  const AuthShowPass(isShow) : super(isShow: isShow);
}

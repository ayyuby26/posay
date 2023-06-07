part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final RequestState status;
  final bool isShowPass;
  const AuthState({this.isShowPass = false, this.status = RequestState.empty});

  @override
  List<Object> get props => [isShowPass, status];
}

class AuthInitial extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLogoutSuccess extends AuthState {}

class AuthShowPass extends AuthState {
  const AuthShowPass(isShowPass) : super(isShowPass: isShowPass);
}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {}

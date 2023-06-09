part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final User? user;
  final RequestState status;
  final bool isShowPass;
  final String message;
  const AuthState(
      {this.message = "",
      this.isShowPass = false,
      this.status = RequestState.empty,
      this.user});

  @override
  List<Object?> get props => [isShowPass, status, user, message];
}

class AuthInitial extends AuthState {}

class AuthLoginSuccess extends AuthState {
  const AuthLoginSuccess(User user) : super(user: user);
}

class AuthLoginFailure extends AuthState {
  const AuthLoginFailure(String message) : super(message: message);
}

class AuthLogoutSuccess extends AuthState {}

class AuthLogoutFailure extends AuthState {
  const AuthLogoutFailure(String message) : super(message: message);
}

class AuthShowPass extends AuthState {
  const AuthShowPass(isShowPass) : super(isShowPass: isShowPass);
}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {}

class AuthLocalUserLoaded extends AuthState {
  const AuthLocalUserLoaded(User user) : super(user: user);
}

class AuthLocalUserFailure extends AuthState {
  const AuthLocalUserFailure(String message) : super(message: message);
}

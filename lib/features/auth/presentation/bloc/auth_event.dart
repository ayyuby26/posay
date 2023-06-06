part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthEvent {
  final String username;
  final String password;
  final BuildContext context;

  const AuthLogin({
    required this.username,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [username, password, context];
}

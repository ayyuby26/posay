part of 'auth_bloc.dart';

final class AuthState extends Equatable {
  final User? user;
  final Status status;
  final bool isShowPass;
  final Failure? failure;
  const AuthState({
    this.failure,
    this.isShowPass = false,
    this.status = Status.initial,
    this.user,
  });

  @override
  List<Object?> get props => [
        isShowPass,
        status,
        user,
        failure,
      ];

  AuthState copyWith({
    User? user,
    Status? status,
    bool? isShowPass,
    Failure? failure,
  }) {
    return AuthState(
      failure: failure ?? this.failure,
      status: status ?? this.status,
      isShowPass: isShowPass ?? this.isShowPass,
      user: user ?? this.user,
    );
  }
}

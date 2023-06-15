import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/features/auth/domain/usecases/get_local_user.dart';
import 'package:posay/features/auth/domain/usecases/login.dart';
import 'package:posay/features/auth/domain/usecases/logout.dart';
import 'package:posay/features/auth/domain/usecases/save_user_to_local_db.dart';
import 'package:posay/shared/failure.dart';
import 'package:posay/shared/status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final Logout _logout;
  final SaveUserToLocalDb _saveUserToLocalDb;
  final GetLocalUser _getLocalUser;
  AuthBloc(
    this._login,
    this._saveUserToLocalDb,
    this._logout,
    this._getLocalUser,
  ) : super(const AuthState()) {
    on<AuthLogin>(_authLogin);
    on<AuthLogout>(_authLogout);
    on<AuthShowPassEvent>(_authShowPassEvent);
    on<AuthGetLocalUser>(_authGetLocalUser);
  }

  FutureOr<void> _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final login = await _login.execute(
      event.username,
      event.password,
    );

    User? user;
    login.fold(
      (l) => emit(state.copyWith(failure: l, status: Status.failure)),
      (r) => user = r,
    );

    if (user != null) {
      final saveUser = _saveUserToLocalDb.execute(user!);
      saveUser.fold(
        (l) => emit(state.copyWith(failure: l, status: Status.failure)),
        (r) => emit(state.copyWith(user: user, status: Status.success)),
      );
    }
  }

  FutureOr<void> _authLogout(AuthLogout event, Emitter<AuthState> emit) {
    final logout = _logout.execute();
    logout.fold(
      (l) => emit(state.copyWith(failure: l, status: Status.failure)),
      (r) => emit(state.copyWith(status: Status.success)),
    );
  }

  FutureOr<void> _authShowPassEvent(
    AuthShowPassEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isShowPass: !state.isShowPass, status: Status.initial));
  }

  _authGetLocalUser(AuthGetLocalUser event, Emitter<AuthState> emit) {
    final result = _getLocalUser.execute();
    result.fold(
      (l) => emit(state.copyWith(failure: l, status: Status.failure)),
      (r) => emit(state.copyWith(user: r, status: Status.success)),
    );
  }
}

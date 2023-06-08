import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/core/state_enum.dart';
import 'package:posay/features/auth/domain/usecases/login.dart';
import 'package:posay/features/auth/domain/usecases/logout.dart';
import 'package:posay/features/auth/domain/usecases/save_user_to_local_db.dart';
import 'package:posay/features/auth/presentation/pages/auth_page.dart';
import 'package:posay/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:posay/shared/extension.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Logout logout;
  final SaveUserToLocalDb saveUserToLocalDb;
  AuthBloc(
    this.login,
    this.saveUserToLocalDb,
    this.logout,
  ) : super(AuthInitial()) {
    on<AuthLogin>(_authLogin);
    on<AuthLogout>(_authLogout);
    on<AuthShowPassEvent>(_authShowPassEvent);
  }

  FutureOr<void> _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await login.execute(
      event.username,
      event.password,
      event.context,
    );
    emit(AuthLoadedState());

    result.fold(event.context.dialogError, (user) {
      saveUserToLocalDb.execute(user);
      event.context.pushReplacement(DashboardPage.path);
      emit(AuthLoginSuccess());
    });
  }

  FutureOr<void> _authLogout(AuthLogout event, Emitter<AuthState> emit) {
    if (event.context.canPop()) event.context.pop();
    final result = logout.execute();
    result.fold(event.context.dialogError, (r) {
      event.context.pushReplacement(AuthPage.path);
      emit(AuthLogoutSuccess());
    });
  }

  FutureOr<void> _authShowPassEvent(
    AuthShowPassEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthShowPass(!state.isShowPass));
  }
}

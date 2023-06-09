import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/core/state_enum.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/features/auth/domain/usecases/get_local_user.dart';
import 'package:posay/features/auth/domain/usecases/login.dart';
import 'package:posay/features/auth/domain/usecases/logout.dart';
import 'package:posay/features/auth/domain/usecases/save_user_to_local_db.dart';
import 'package:posay/features/auth/presentation/pages/auth_page.dart';
import 'package:posay/features/dashboard/presentation/pages/dashboard_page.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Logout logout;
  final SaveUserToLocalDb saveUserToLocalDb;
  final GetLocalUser getLocalUser;
  AuthBloc(
    this.login,
    this.saveUserToLocalDb,
    this.logout,
    this.getLocalUser,
  ) : super(AuthInitial()) {
    on<AuthLogin>(_authLogin);
    on<AuthLogout>(_authLogout);
    on<AuthShowPassEvent>(_authShowPassEvent);
    on<AuthGetLocalUser>(_authGetLocalUser);
  }

  FutureOr<void> _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await login.execute(
      event.username,
      event.password,
      event.context,
    );
    emit(AuthLoadedState());

    result.fold((l) => emit(AuthLoginFailure(l.message)), (user) {
      saveUserToLocalDb.execute(user);

      if (event.context.canPop()) event.context.pop();
      event.context.pushReplacement(DashboardPage.path);
      emit(AuthLoginSuccess(user));
    });
  }

  FutureOr<void> _authLogout(AuthLogout event, Emitter<AuthState> emit) {
    if (event.context.canPop()) event.context.pop();
    final result = logout.execute();
    result.fold((l) => emit(AuthLogoutFailure(l.message)), (r) {
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

  FutureOr<void> _authGetLocalUser(
      AuthGetLocalUser event, Emitter<AuthState> emit) {
    final result = getLocalUser.execute();
    result.fold((l) => emit(AuthLocalUserFailure(l.message)),
        (r) => emit(AuthLocalUserLoaded(r)));
  }
}

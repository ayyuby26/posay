import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/auth/domain/usecases/login.dart';
import 'package:posay/features/auth/domain/usecases/save_user_to_local_db.dart';
import 'package:posay/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:posay/shared/failure.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final SaveUserToLocalDb saveUserToLocalDb;
  AuthBloc(this.login, this.saveUserToLocalDb) : super(AuthInitial()) {
    on<AuthLogin>(_authLogin);
  }

  String _message = "";
  String get message => _message;

  void _setMessage(Failure failure) => _message = failure.message;

  FutureOr<void> _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final result = await login.execute(event.username, event.password);

    result.fold(_setMessage, (user) {
      saveUserToLocalDb.execute(user);
      event.context.replace(DashboardPage.path);
    });
  }
}

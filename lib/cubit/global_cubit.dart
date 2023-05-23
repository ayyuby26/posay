import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit()
      : super(GlobalInitial(locale: AppLocalizations.supportedLocales[0]));

  void changeLocal() {
    final status = state;
    if (status is GlobalInitial) {
      final index = status.locale.languageCode == 'en' ? 1 : 0;
      emit(status.clone(AppLocalizations.supportedLocales[index]));
    }
  }
}

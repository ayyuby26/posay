import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posay/features/language/data/datasources/language_data_source.dart';
import 'package:posay/features/language/data/models/language_model.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageDataSource languageDataSource;
  LanguageBloc({required this.languageDataSource})
      : super(
          LanguageInitial(
            locale: Locale(
              languageDataSource.getDefaultLanguage().code,
            ),
          ),
        ) {
    on<ChangeLanguageEvent>(_changeLanguageEvent);
  }

  FutureOr<void> _changeLanguageEvent(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) {
    final ss = languageDataSource
        .getLanguages()
        .firstWhere((e) => e.code != state.locale.languageCode);

    languageDataSource.saveLanguage(
      LanguageModel(
        code: ss.code,
        name: ss.name,
      ),
    );
    emit(LanguageSelected(locale: Locale(ss.code)));
  }
}

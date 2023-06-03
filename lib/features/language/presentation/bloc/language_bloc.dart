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
      : super(const LanguageInit()) {
    on<LoadLanguageEvent>(_loadLanguageEvent);
    on<ChangeLanguageEvent>(_changeLanguageEvent);
  }

  FutureOr<void> _loadLanguageEvent(
    LoadLanguageEvent event,
    Emitter<LanguageState> emit,
  ) {
    final data = languageDataSource.getSavedLanguages();

    // successfully got the data from Database
    final success = data.$1.message.isEmpty;

    if (success) {
      final languageModel = LanguageModel(
        code: data.$2.code,
        name: data.$2.name,
      );

      languageDataSource.saveLanguage(languageModel);

      emit(LanguageUpdateState(locale: Locale(languageModel.code)));
    } else {
      final defaultLang = languageDataSource.getDefaultLanguage();
      languageDataSource.saveLanguage(
        LanguageModel(
          code: defaultLang.code,
          name: defaultLang.name,
        ),
      );

      emit(LanguageUpdateState(locale: Locale(defaultLang.code)));
    }
  }

  FutureOr<void> _changeLanguageEvent(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) {
    final ss = languageDataSource
        .getLanguages()
        .firstWhere((e) => e.code != event.locale.languageCode);
        
    languageDataSource.saveLanguage(
      LanguageModel(
        code: ss.code,
        name: ss.name,
      ),
    );

    emit(LanguageUpdateState(locale: Locale(ss.code)));
  }
}

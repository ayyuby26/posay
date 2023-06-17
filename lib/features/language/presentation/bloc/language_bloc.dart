import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posay/features/language/domain/entities/language.dart';
import 'package:posay/features/language/domain/usecases/get_default_language.dart';
import 'package:posay/features/language/domain/usecases/get_languages.dart';
import 'package:posay/features/language/domain/usecases/get_saved_language.dart';
import 'package:posay/features/language/domain/usecases/save_language.dart';
import 'package:posay/shared/failure.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetSavedLanguage _getSavedLanguage;
  final SaveLanguageToLocalDb _saveLanguageToLocalDb;
  final GetLanguages _getLanguages;
  final GetDefaultLanguage _getDefaultLanguage;

  LanguageBloc(
    this._getDefaultLanguage,
    this._getLanguages,
    this._getSavedLanguage,
    this._saveLanguageToLocalDb,
  ) : super(const LanguageState()) {
    on<LoadLanguageEvent>(_loadLanguageEvent);
    on<ChangeLanguageEvent>(_changeLanguageEvent);
    on<LanguageGetDefault>(_languageGetDefault);
  }

  _loadLanguageEvent(
    LoadLanguageEvent event,
    Emitter<LanguageState> emit,
  ) {
    final savedLanguage = _getSavedLanguage.execute();

    Language? langSelected;

    savedLanguage.fold(
      (l) => emit(state.copyWith(failure: l)),
      (r) => langSelected = r,
    );

    if (langSelected != null) {
      return emit(
        state.copyWith(languageSelected: Locale(langSelected!.code)),
      );
    }

    final defaultLang = _getDefaultLanguage.execute();
    defaultLang.fold(
      (l) => emit(state.copyWith(failure: l)),
      (r) {
        emit(state.copyWith(languageSelected: Locale(r.code)));
        langSelected = r;
      },
    );

    final saveToLocal = _saveLanguageToLocalDb.execute(langSelected!);
    if (saveToLocal) {
      final languageUpdateState = state.copyWith(
        languageSelected: Locale(langSelected!.code),
      );
      return emit(languageUpdateState);
    }
  }

  FutureOr<void> _changeLanguageEvent(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) {
    Language? languageSelected;
    List<Language>? languages;

    final getLanguages = _getLanguages.execute();
    getLanguages.fold(
      (l) => emit(state.copyWith(failure: l)),
      (r) => languages = r,
    );

    languageSelected =
        languages?.firstWhere((e) => e.code != event.locale.languageCode);

    if (languageSelected == null) return null;
    final save = _saveLanguageToLocalDb.execute(languageSelected);
    if (save == false) return null;

    emit(state.copyWith(
      languageSelected: Locale(languageSelected.code),
    ));
  }

  _languageGetDefault(LanguageGetDefault event, Emitter<LanguageState> emit) {
    final result = _getDefaultLanguage.execute();
    result.fold(
      (l) => emit(state.copyWith(failure: l)),
      (r) => emit(state.copyWith(defaultLanguage: r)),
    );
  }
}

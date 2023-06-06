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
  GetSavedLanguage getSavedLanguage;
  SaveLanguageToLocalDb saveLanguageToLocalDb;
  GetLanguages getLanguages;
  GetDefaultLanguage getDefaultLanguage;

  String _message = "";
  late Language _language;

  LanguageBloc({
    required this.getDefaultLanguage,
    required this.getLanguages,
    required this.getSavedLanguage,
    required this.saveLanguageToLocalDb,
  }) : super(const LanguageInit()) {
    on<LoadLanguageEvent>(_loadLanguageEvent);
    on<ChangeLanguageEvent>(_changeLanguageEvent);
  }

  void _setMessage(Failure failure) => _message = failure.message;

  FutureOr<void> _loadLanguageEvent(
    LoadLanguageEvent event,
    Emitter<LanguageState> emit,
  ) {
    final savedLanguage = getSavedLanguage.execute();

    savedLanguage.fold((l) {
      final defaultLang = getDefaultLanguage.execute();
      defaultLang.fold(_setMessage, (r) => _language = r);
    }, (r) => _language = r);

    saveLanguageToLocalDb.execute(_language);

    final languageUpdateState = LanguageUpdateState(
      locale: Locale(_language.code),
      message: _message,
    );

    emit(languageUpdateState);
  }

  FutureOr<void> _changeLanguageEvent(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) {
    try {
      final languages = getLanguages.execute();

      languages.fold(_setMessage, (r) {
        _language = r.firstWhere((e) => e.code != event.locale.languageCode);
      });

      saveLanguageToLocalDb.execute(_language);

      final languageUpdateState = LanguageUpdateState(
        locale: Locale(_language.code),
        message: _message,
      );

      emit(languageUpdateState);
    } catch (e) {
      _message = e.toString();
    }
  }
}

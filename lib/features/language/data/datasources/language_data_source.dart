import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/features/language/data/models/language_model.dart';
import 'package:posay/features/language/domain/entities/language.dart';
import 'package:posay/core/failure.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class LanguageDataSource {
  (Failure, Language) getSavedLanguages();
  List<Language> getLanguages();
  Language getDefaultLanguage();
  bool saveLanguage(LanguageModel languageModel);
}

class LanguageDataSourceImpl extends LanguageDataSource {
  final List<Locale> supportedLocales = AppLocalizations.supportedLocales;
  Box<LanguageModel> objectBoxLanguage;

  LanguageDataSourceImpl({
    required this.objectBoxLanguage,
  });

  @override
  Language getDefaultLanguage() {
    final Locale locale = supportedLocales.first;
    return Language(
      code: locale.languageCode,
      name: locale.languageCode.toUpperCase(),
    );
  }

  @override
  List<Language> getLanguages() {
    return supportedLocales
        .map((e) => Language(
              code: e.languageCode,
              name: e.languageCode.toUpperCase(),
            ))
        .toList();
  }

  @override
  (Failure, Language) getSavedLanguages() {
    Failure db = const LocalDatabaseFailure("");
    late Language language;
    try {
      final data = objectBoxLanguage.getAll();
      if (data.isEmpty) {
      } else {
        final dd = data.first;
        language = Language(code: dd.code, name: dd.name);
      }
    } catch (e) {
      db = LocalDatabaseFailure(e.toString());
    }
    return (db, language);
  }

  @override
  bool saveLanguage(LanguageModel languageModel) {
    bool result = false;
    objectBoxLanguage.put(languageModel);
    result = true;
    return result;
  }
}

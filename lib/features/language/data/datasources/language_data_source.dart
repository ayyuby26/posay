import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/features/language/data/models/language_model.dart';
import 'package:posay/features/language/domain/entities/language.dart';

abstract class LanguageDataSource {
  Language getSavedLanguage();
  List<Language> getLanguages();
  Language getDefaultLanguage();
  bool saveLanguageToLocalDb(Language language);
}

class LanguageDataSourceImpl extends LanguageDataSource {
  final List<Locale> supportedLocales;
  final Box<LanguageModel> objectBoxLanguage;

  LanguageDataSourceImpl({
    required this.objectBoxLanguage,
    required this.supportedLocales,
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
  Language getSavedLanguage() {
    final List<LanguageModel> languages = objectBoxLanguage.getAll();
    if (languages.isNotEmpty) return languages.first.toEntity();
    return getDefaultLanguage();
  }

  @override
  bool saveLanguageToLocalDb(Language language) {
    objectBoxLanguage.removeAll();
    final int result = objectBoxLanguage.put(language.toModel());
    return result == 1;
  }
}

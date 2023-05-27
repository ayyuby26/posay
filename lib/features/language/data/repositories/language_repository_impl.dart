import 'package:posay/features/language/data/datasources/language_data_source.dart';
import 'package:posay/features/language/data/models/language_model.dart';
import 'package:posay/features/language/domain/entities/language.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';
import 'package:posay/core/failure.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  LanguageDataSource languageDataSource;
  LanguageRepositoryImpl({required this.languageDataSource});

  @override
  Language defaultLanguage() {
    return languageDataSource.getDefaultLanguage();
  }

  @override
  List<Language> getLanguages() {
    return languageDataSource.getLanguages();
  }

  @override
  (Failure, Language) getSavedLanguages() {
    Failure fail;
    late Language data;
    try {
      data = languageDataSource.getSavedLanguages().$2;
      fail = languageDataSource.getSavedLanguages().$1;
    } catch (e) {
      fail = LocalDatabaseFailure(e.toString());
    }
    return (fail, data);
  }

  @override
  bool saveLanguage(LanguageModel languageModel) {
    bool result = false;
    try {
      languageDataSource.saveLanguage(languageModel);
      result = true;
      return result;
    } catch (e) {
      rethrow;
    }
  }
}

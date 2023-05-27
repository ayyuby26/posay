import 'package:posay/features/language/data/models/language_model.dart';
import 'package:posay/features/language/domain/entities/language.dart';
import 'package:posay/core/failure.dart';

abstract class LanguageRepository {
  (Failure, Language) getSavedLanguages();
  List<Language> getLanguages();
  Language defaultLanguage();
  bool saveLanguage(LanguageModel languageModel);
}

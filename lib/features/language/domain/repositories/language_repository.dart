import 'package:dartz/dartz.dart';
import 'package:posay/features/language/domain/entities/language.dart';
import 'package:posay/shared/failure.dart';

abstract class LanguageRepository {
  Either<Failure, Language> getSavedLanguage();
  Either<Failure, List<Language>> getLanguages();
  Either<Failure, Language> defaultLanguage();
  bool saveLanguageToLocalDb(Language language);
}

import 'package:dartz/dartz.dart';
import 'package:posay/features/language/data/datasources/language_data_source.dart';
import 'package:posay/features/language/domain/entities/language.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';
import 'package:posay/shared/failure.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  LanguageDataSource languageDataSource;
  LanguageRepositoryImpl({required this.languageDataSource});

  @override
  Either<Failure, Language> defaultLanguage() {
    try {
      return Right(languageDataSource.getDefaultLanguage());
    } catch (e) {
      return const Left(LocalDatabaseFailure());
    }
  }

  @override
  Either<Failure, List<Language>> getLanguages() {
    final List<Language> languages = languageDataSource.getLanguages();
    if (languages.isEmpty) return const Left(LocalDatabaseFailure());
    return Right(languages);
  }

  @override
  Either<Failure, Language> getSavedLanguage() {
    try {
      return Right(languageDataSource.getSavedLanguage());
    } catch (e) {
      return Left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  bool saveLanguageToLocalDb(Language language) {
    bool result = false;
    try {
      result = languageDataSource.saveLanguageToLocalDb(language);
      return result;
    } catch (e) {
      throw LocalDatabaseFailure(e);
    }
  }
}

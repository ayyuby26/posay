import 'package:dartz/dartz.dart';
import 'package:posay/features/language/domain/entities/language.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';
import 'package:posay/shared/failure.dart';

class GetSavedLanguage {
  final LanguageRepository languageRepository;

  GetSavedLanguage({required this.languageRepository});

  Either<Failure, Language> execute() {
    return languageRepository.getSavedLanguage();
  }
}

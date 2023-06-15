import 'package:dartz/dartz.dart';
import 'package:posay/features/language/domain/entities/language.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';
import 'package:posay/shared/failure.dart';

class GetLanguages {
  final LanguageRepository languageRepository;

  GetLanguages({required this.languageRepository});

  Either<Failure, List<Language>> execute() {
    return languageRepository.getLanguages();
  }
}

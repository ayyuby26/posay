import 'package:posay/features/language/domain/entities/language.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';

class GetLanguages {
  final LanguageRepository languageRepository;

  GetLanguages({required this.languageRepository});

  List<Language> execute() {
    final List<Language> languages = languageRepository.getLanguages();
    return languages;
  }
}

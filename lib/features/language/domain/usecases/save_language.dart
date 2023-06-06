import 'package:posay/features/language/domain/entities/language.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';

class SaveLanguageToLocalDb {
  final LanguageRepository languageRepository;

  SaveLanguageToLocalDb({required this.languageRepository});

  bool execute(Language language) {
    final bool languages = languageRepository.saveLanguageToLocalDb(language);
    return languages;
  }
}

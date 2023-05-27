import 'package:posay/features/language/data/models/language_model.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';

class SaveLanguage {
  final LanguageRepository languageRepository;

  SaveLanguage({required this.languageRepository});

  bool execute(LanguageModel languageModel) {
    final bool languages = languageRepository.saveLanguage(languageModel);
    return languages;
  }
}

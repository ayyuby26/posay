import 'package:posay/features/intro/domain/entities/intro.dart';
import 'package:posay/features/intro/domain/repositories/intro_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetIntro {
  final IntroRepository introRepository;

  GetIntro({required this.introRepository});

  List<Intro> execute(AppLocalizations appLocalizations) {
    return introRepository.getIntroContents(appLocalizations);
  }
}

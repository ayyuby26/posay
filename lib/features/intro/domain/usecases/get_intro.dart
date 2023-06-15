import 'package:dartz/dartz.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';
import 'package:posay/features/intro/domain/repositories/intro_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:posay/shared/failure.dart';

class GetIntro {
  final IntroRepository introRepository;

  GetIntro({required this.introRepository});

  Either<Failure, List<Intro>> execute(AppLocalizations appLocalizations) {
    return introRepository.getIntroContents(appLocalizations);
  }
}

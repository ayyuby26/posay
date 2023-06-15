import 'package:dartz/dartz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';
import 'package:posay/shared/failure.dart';

abstract class IntroRepository {
  Either<Failure, List<Intro>> getIntroContents(
      AppLocalizations appLocalizations);
  Either<Failure, bool> isIntroSeen();
  Either<Failure, bool> saveIntro(Intro intro);
}

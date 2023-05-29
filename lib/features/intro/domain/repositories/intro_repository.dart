import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';

abstract class IntroRepository {
  List<Intro> getIntroContents(AppLocalizations appLocalizations);
}

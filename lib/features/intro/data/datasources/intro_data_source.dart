import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:posay/features/intro/data/models/intro_model.dart';

abstract class IntroDataSource {
  List<IntroModel> getIntroList(AppLocalizations appLocalizations);
}

class IntroDataSourceImpl implements IntroDataSource {
  @override
  List<IntroModel> getIntroList(AppLocalizations appLocalizations) {
    return [
      IntroModel(
        icon: Icons.storefront,
        desc: appLocalizations.introDesc1,
      ),
      IntroModel(
        icon: Icons.calculate_outlined,
        desc: appLocalizations.introDesc2,
      ),
      IntroModel(
        icon: Icons.analytics_outlined,
        desc: appLocalizations.introDesc3,
      ),
    ];
  }
}

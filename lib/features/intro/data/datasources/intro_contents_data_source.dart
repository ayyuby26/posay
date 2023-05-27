import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:posay/features/intro/data/models/intro_content.dart'; 

abstract class IntroContentsDataSource {
  List<IntroContent> getIntroContents(AppLocalizations appLocalizations);
}

class IntroContentsDataSourceImpl implements IntroContentsDataSource {
  @override
  List<IntroContent> getIntroContents(AppLocalizations appLocalizations) {
    return [
      IntroContent(
        icon: Icons.storefront,
        desc: appLocalizations.introDesc1,
      ),
      IntroContent(
        icon: Icons.calculate_outlined,
        desc: appLocalizations.introDesc2,
      ),
      IntroContent(
        icon: Icons.analytics_outlined,
        desc: appLocalizations.introDesc3,
      ),
    ];
  }
}

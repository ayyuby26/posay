import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/features/intro/data/models/intro_model.dart';

abstract class IntroDataSource {
  List<IntroModel> getIntroList(AppLocalizations appLocalizations);
  void saveIntro(IntroModel intro);
}

class IntroDataSourceImpl implements IntroDataSource {
  final Box<IntroModel> box;
  IntroDataSourceImpl(this.box);

  @override
  List<IntroModel> getIntroList(AppLocalizations appLocalizations) {
    return [
      IntroModel(
        iconCodePoint: Icons.storefront.codePoint,
        desc: appLocalizations.introDesc1,
      ),
      IntroModel(
        iconCodePoint: Icons.calculate_outlined.codePoint,
        desc: appLocalizations.introDesc2,
      ),
      IntroModel(
        iconCodePoint: Icons.analytics_outlined.codePoint,
        desc: appLocalizations.introDesc3,
      ),
    ];
  }

  @override
  void saveIntro(IntroModel introModel) {
    box.put(introModel);
  }
}

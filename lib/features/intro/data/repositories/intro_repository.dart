import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:posay/features/intro/data/datasources/intro_contents_data_source.dart';
import 'package:posay/features/intro/data/models/intro_content.dart';
import 'package:posay/shared/extension.dart';

abstract class IntroRepository {
  List<IntroContent> getIntroContents(AppLocalizations appLocalizations);
}

class IntroRepositoryImpl implements IntroRepository {
  final IntroContentsDataSource dataSource;

  IntroRepositoryImpl({required this.dataSource});

  @override
  List<IntroContent> getIntroContents(AppLocalizations appLocalizations) {
    return dataSource.getIntroContents(appLocalizations);
  }
}

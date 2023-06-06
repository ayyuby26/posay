import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:posay/features/intro/data/datasources/intro_data_source.dart';
import 'package:posay/features/intro/data/models/intro_model.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';
import 'package:posay/features/intro/domain/repositories/intro_repository.dart';
import 'package:posay/shared/failure.dart';

class IntroRepositoryImpl implements IntroRepository {
  final IntroDataSource dataSource;

  IntroRepositoryImpl({required this.dataSource});

  @override
  List<Intro> getIntroContents(AppLocalizations appLocalizations) {
    final introList = dataSource.getIntroList(appLocalizations);
    return introList.map((e) => e.toEntity()).toList();
  }

  @override
  void saveIntro(IntroModel intro) {
    try {
      dataSource.saveIntro(intro);
    } catch (e) {
      throw const LocalDatabaseFailure();
    }
  }
}

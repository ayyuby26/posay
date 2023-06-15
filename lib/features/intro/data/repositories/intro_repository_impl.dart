import 'package:dartz/dartz.dart';
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
  Either<Failure, List<Intro>> getIntroContents(
    AppLocalizations appLocalizations,
  ) {
    try {
      final introList = dataSource.getIntroList(appLocalizations);
      return Right(introList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure("$e"));
    }
  }

  @override
  Either<Failure, bool> isIntroSeen() {
    try {
      final result = dataSource.isIntroSeen();
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(e));
    }
  }

  @override
  Either<Failure, bool> saveIntro(Intro intro) {
    try {
      dataSource.saveIntro(IntroModel.fromEntity(intro));
      return const Right(true);
    } catch (e) {
      return Left(LocalDatabaseFailure(e));
    }
  }
}

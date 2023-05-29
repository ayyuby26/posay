import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/core/local_storage/object_box.dart';
import 'package:posay/features/intro/data/datasources/intro_data_source.dart';
import 'package:posay/features/intro/data/repositories/intro_repository.dart';
import 'package:posay/features/intro/domain/repositories/intro_repository.dart';
import 'package:posay/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:posay/features/language/data/datasources/language_data_source.dart';
import 'package:posay/features/language/data/models/language_model.dart';
import 'package:posay/features/language/data/repositories/language_repository_impl.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';
import 'package:posay/features/language/domain/usecases/get_languages.dart';
import 'package:posay/features/language/domain/usecases/save_language.dart';
import 'package:posay/features/language/presentation/bloc/language_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => IntroBloc(introRepository: locator()));
  locator.registerFactory(() => LanguageBloc(languageDataSource: locator()));

  // use case
  locator
      .registerLazySingleton(() => GetLanguages(languageRepository: locator()));
  locator
      .registerLazySingleton(() => SaveLanguage(languageRepository: locator()));

  // repository
  locator.registerLazySingleton<IntroRepository>(
      () => IntroRepositoryImpl(dataSource: locator()));
  locator.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl(languageDataSource: locator()));

  // data sources
  locator.registerLazySingleton<IntroDataSource>(() => IntroDataSourceImpl());
  locator.registerLazySingleton<LanguageDataSource>(
      () => LanguageDataSourceImpl(objectBoxLanguage: locator()));

  // helper
  // locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton<Box<LanguageModel>>(
      () => store.box<LanguageModel>());
}

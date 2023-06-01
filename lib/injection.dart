import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/core/local_storage/object_box.dart';
import 'package:posay/core/theme_app.dart';
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
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/constants/constants.dart';
import 'package:posay/shared/constants/media_query_screen_size_provider.dart';

final locator = GetIt.instance;

void init(Store store) {
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
  locator.registerLazySingleton<ObjectBox>(() => ObjectBox(store));
  locator.registerLazySingleton<Box<LanguageModel>>(
      () => store.box<LanguageModel>());

  // constants
  locator.registerLazySingleton<Constants>(
    () => Constants(screenSizeProvider: MediaQueryScreenSizeProvider()),
  );

  locator.registerLazySingleton<IColor>(() => IColor());
  locator.registerLazySingleton<ITheme>(() => ITheme(locator()));
}

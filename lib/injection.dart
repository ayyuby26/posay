import 'package:appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/core/appwrite_client.dart';
import 'package:posay/core/config/appwrite_config.dart';
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

class Injection {
  static final Injection _instance = Injection._internal();

  factory Injection() {
    return _instance;
  }

  Injection._internal();

  final _locator = GetIt.instance;

  GetIt get locator => _locator;

  init(Store store) {
    // provider
    _locator.registerFactory(() => IntroBloc(introRepository: _locator()));
    _locator
        .registerFactory(() => LanguageBloc(languageDataSource: _locator()));

    // use case
    _locator.registerLazySingleton(
        () => GetLanguages(languageRepository: _locator()));
    _locator.registerLazySingleton(
        () => SaveLanguage(languageRepository: _locator()));

    // repository
    _locator.registerLazySingleton<IntroRepository>(
        () => IntroRepositoryImpl(dataSource: _locator()));
    _locator.registerLazySingleton<LanguageRepository>(
        () => LanguageRepositoryImpl(languageDataSource: _locator()));

    // data sources
    _locator
        .registerLazySingleton<IntroDataSource>(() => IntroDataSourceImpl());
    _locator.registerLazySingleton<LanguageDataSource>(
        () => LanguageDataSourceImpl(objectBoxLanguage: _locator()));

    // helper
    // _locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

    // external
    _locator.registerLazySingleton<ObjectBox>(() => ObjectBox(store));
    _locator.registerLazySingleton<AppwriteConfig>(() => AppwriteConfig());
    _locator.registerLazySingleton<Client>(
        () => AppwriteClient(_locator()).setAppWriteConfig());
    _locator.registerFactory<Box<LanguageModel>>(
      () => store.box<LanguageModel>(),
    );

    // constants
    _locator.registerLazySingleton<Constants>(
      () => Constants(screenSizeProvider: MediaQueryScreenSizeProvider()),
    );

    _locator.registerLazySingleton<IColor>(() => IColor());
    _locator.registerLazySingleton<ITheme>(() => ITheme(_locator()));
  }
}

import 'package:appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/core/appwrite_client.dart';
import 'package:posay/core/config/appwrite_config.dart';
import 'package:posay/core/db_constants_id.dart';
import 'package:posay/core/local_storage/object_box.dart';
import 'package:posay/core/theme_app.dart';
import 'package:posay/features/auth/data/datasources/user_data_source.dart';
import 'package:posay/features/auth/data/models/user_model.dart';
import 'package:posay/features/auth/data/repositories/user_repository_impl.dart';
import 'package:posay/features/auth/domain/repositories/user_repository.dart';
import 'package:posay/features/auth/domain/usecases/get_local_user.dart';
import 'package:posay/features/auth/domain/usecases/login.dart';
import 'package:posay/features/auth/domain/usecases/logout.dart';
import 'package:posay/features/auth/domain/usecases/save_user_to_local_db.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/features/dashboard/features/stock/data/datasources/stock_data_source.dart';
import 'package:posay/features/dashboard/features/stock/data/repositories/stock_repository_impl.dart';
import 'package:posay/features/dashboard/features/stock/domain/repositories/stock_repository.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/add_stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/delete_stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/get_stock_list.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/next_page_stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/search_stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/usecases/update_stock.dart';
import 'package:posay/features/dashboard/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:posay/features/intro/data/datasources/intro_data_source.dart';
import 'package:posay/features/intro/data/models/intro_model.dart';
import 'package:posay/features/intro/data/repositories/intro_repository_impl.dart';
import 'package:posay/features/intro/domain/repositories/intro_repository.dart';
import 'package:posay/features/intro/domain/usecases/get_intro.dart';
import 'package:posay/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:posay/features/language/data/datasources/language_data_source.dart';
import 'package:posay/features/language/data/models/language_model.dart';
import 'package:posay/features/language/data/repositories/language_repository_impl.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';
import 'package:posay/features/language/domain/usecases/get_default_language.dart';
import 'package:posay/features/language/domain/usecases/get_languages.dart';
import 'package:posay/features/language/domain/usecases/get_saved_language.dart';
import 'package:posay/features/language/domain/usecases/save_language.dart';
import 'package:posay/features/language/presentation/bloc/language_bloc.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Injector {
  static Injector? _instance;

  factory Injector() {
    _instance ??= Injector._();
    return _instance!;
  }

  Injector._();

  static final _locator = GetIt.instance;

  static GetIt get gett => _locator;

  static void init(Store store) {
    // languages from lib/l10n/*.arb
    _locator.registerFactory(() => AppLocalizations.supportedLocales);

    // [ PROVIDER ]-------------------------------------------------------------
    _locator.registerFactory(
        () => StockBloc(_locator(), _locator(), _locator(), _locator(),_locator(),_locator()));
    _locator.registerFactory(
        () => AuthBloc(_locator(), _locator(), _locator(), _locator()));
    _locator.registerFactory(() => IntroBloc(getIntro: _locator()));
    _locator.registerFactory(
      () => LanguageBloc(
        getDefaultLanguage: _locator(),
        getLanguages: _locator(),
        getSavedLanguage: _locator(),
        saveLanguageToLocalDb: _locator(),
      ),
    );

    // [ USECASE ]--------------------------------------------------------------
    // STOCK
    _locator.registerLazySingleton(
      () => GetStockList(stockRepository: _locator()),
    );
    _locator.registerLazySingleton(
      () => UpdateStock(stockRepository: _locator()),
    );
    _locator.registerLazySingleton(() => AddStock(stockRepository: _locator()));
    _locator.registerLazySingleton(
      () => NextPageStock(stockRepository: _locator()),
    );
    _locator.registerLazySingleton(
      () => SearchStock(stockRepository: _locator()),
    );
    _locator.registerLazySingleton(
      () => DeleteStock(stockRepository: _locator()),
    );

    // intro
    _locator.registerLazySingleton(() => GetIntro(introRepository: _locator()));

    // language
    _locator.registerLazySingleton(
      () => GetSavedLanguage(languageRepository: _locator()),
    );
    _locator.registerLazySingleton(
      () => SaveLanguageToLocalDb(languageRepository: _locator()),
    );
    _locator.registerLazySingleton(
      () => GetDefaultLanguage(languageRepository: _locator()),
    );
    _locator.registerLazySingleton(
      () => GetLanguages(languageRepository: _locator()),
    );

    // Auth
    _locator.registerLazySingleton(() => Logout(userRepository: _locator()));
    _locator
        .registerLazySingleton(() => GetLocalUser(userRepository: _locator()));
    _locator.registerLazySingleton(() => Login(userRepository: _locator()));
    _locator.registerLazySingleton(
        () => SaveUserToLocalDb(userRepository: _locator()));

    // [ REPOSITORY ]-----------------------------------------------------------
    // STOCK
    _locator.registerLazySingleton<StockRepository>(
      () => StockRepositoryImpl(_locator()),
    );

    _locator.registerLazySingleton<IntroRepository>(
        () => IntroRepositoryImpl(dataSource: _locator()));
    _locator.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(_locator(), _locator()));
    _locator.registerLazySingleton<LanguageRepository>(
        () => LanguageRepositoryImpl(languageDataSource: _locator()));

    // [ DATA SOURCES ]---------------------------------------------------------
    // STOCK
    _locator.registerLazySingleton<StockDataSource>(
      () => StockDataSourceImpl(_locator()),
    );

    _locator.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(_locator(), _locator()),
    );
    _locator.registerLazySingleton<IntroDataSource>(
      () => IntroDataSourceImpl(_locator()),
    );
    _locator.registerLazySingleton<LanguageDataSource>(
      () => LanguageDataSourceImpl(
        objectBoxLanguage: _locator(),
        supportedLocales: _locator(),
      ),
    );

    // helper
    // _locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

    // external
    _locator.registerLazySingleton<ObjectBox>(() => ObjectBox(store));
    _locator.registerLazySingleton<AppwriteConfig>(() => AppwriteConfig());
    _locator.registerLazySingleton<Client>(
        () => AppwriteClient(_locator()).setAppWriteConfig());
    _locator.registerLazySingleton<Databases>(() => Databases(_locator()));
    _locator.registerFactory<Box<LanguageModel>>(
      () => store.box<LanguageModel>(),
    );
    _locator.registerFactory<Box<UserModel>>(
      () => store.box<UserModel>(),
    );
    _locator.registerFactory<Box<IntroModel>>(
      () => store.box<IntroModel>(),
    );

    // constants
    _locator.registerLazySingleton(() => DbConstantsId());

    _locator.registerLazySingleton<IColor>(() => IColor());
    _locator.registerLazySingleton<ITheme>(() => ITheme());
  }
}

import 'package:get_it/get_it.dart';
import 'package:posay/features/intro/data/datasources/intro_contents_data_source.dart';
import 'package:posay/features/intro/data/repositories/intro_repository.dart';
import 'package:posay/features/intro/presentation/bloc/intro_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => IntroBloc(introRepository: locator()));

  // use case
  // locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));

  // repository
  locator.registerLazySingleton<IntroRepository>(
      () => IntroRepositoryImpl(dataSource: locator()));

  // data sources
  locator.registerLazySingleton<IntroContentsDataSource>(
      () => IntroContentsDataSourceImpl());

  // helper
  // locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  // locator.registerLazySingleton(() => http.Client());
}

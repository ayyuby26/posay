import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:posay/core/setup.dart';
import 'package:posay/core/theme_app.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/features/dashboard/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:posay/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:posay/features/language/presentation/bloc/language_bloc.dart';
import 'core/route/router.dart';
import 'package:posay/injector.dart';

void main() async {
  await Setup().init();
  final iTheme = Injector.gett<ITheme>();
  runApp(App(iTheme));
}

class App extends StatelessWidget {
  final ITheme _theme;

  const App(this._theme, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              Injector.gett<LanguageBloc>()..add(const LoadLanguageEvent()),
        ),
        BlocProvider(create: (_) => Injector.gett<AuthBloc>()),
        BlocProvider(create: (_) => Injector.gett<StockBloc>()),
        BlocProvider(create: (_) => Injector.gett<IntroBloc>()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp.router(
            locale: state.languageSelected,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
            theme: _theme.base,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

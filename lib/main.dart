import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:posay/core/setup.dart';
import 'package:posay/core/theme_app.dart';
import 'package:posay/features/language/presentation/bloc/language_bloc.dart';
import 'core/route/go_router.dart';
import 'package:posay/injection.dart' as di;

void main() async {
  await Application().setup();
  final iTheme = di.locator<ITheme>();
  runApp(App(iTheme));
}

class App extends StatelessWidget {
  final ITheme _theme;

  const App(this._theme, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>(
      create: (context) => di.locator<LanguageBloc>(),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp.router(
            locale: state.locale,
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

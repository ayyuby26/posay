import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:posay/core/setup_run.dart';
import 'package:posay/core/theme_app.dart';
import 'package:posay/cubit/global_cubit.dart';
import 'core/route/go_router.dart';

void main() async {
  await SetUp.base();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalCubit>(
      create: (context) => GlobalCubit(),
      child: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          final status = state;
          if (status is GlobalInitial) {
            return MaterialApp.router(
              showPerformanceOverlay: true,
              locale: status.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: router,
              theme: ThemeApp.base,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
 

import 'package:easy_localization/easy_localization.dart';
import 'package:posay/color.dart';
import 'package:flutter/material.dart';
import 'core/route/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('id', 'ID'),
        Locale('en', 'US'),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    context.setLocale(const Locale('en', 'US'));
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: const ColorScheme.light(primary: color2),
        useMaterial3: true,
        scaffoldBackgroundColor: color1,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          surfaceTintColor: Colors.blue,
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("data"),
      ),
    );
  }
}

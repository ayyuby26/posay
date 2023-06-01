import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:posay/core/setup.dart';
import 'package:posay/core/theme_app.dart';
import 'package:posay/main.dart';
import 'package:posay/injection.dart' as di;

void main() {
  group("Intro Group", () {
    setUp(() async {
      // await Application().runApp();
      
    });
    testWidgets("Intro Data Test", (WidgetTester tester) async {
      // await tester.pumpAndSettle();
      // Bisa
      // await tester.pumpWidget(
      //   const MaterialApp(
      //     home: MaterialApp(
      //       // locale: AppLocalizations.supportedLocales.first,
      //       localizationsDelegates: AppLocalizations.localizationsDelegates,
      //       supportedLocales: AppLocalizations.supportedLocales,
      //       home: MyWidget(),
      //     ),
      //   ),
      // );

      await tester.pumpWidget(App(di.locator<ITheme>()));
      await tester.pumpAndSettle();

      // Verify that our text is English
      expect(find.text('Finish'), findsWidgets);

      // Set the app's locale to Spanish
      await tester.binding.setLocale('id', '');
      await tester.pumpAndSettle();

      // Verify that our text is Indonesia
      expect(find.text('Selesai'), findsWidgets);
    });
  });
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(AppLocalizations.of(context).finish),
    );
  }
}

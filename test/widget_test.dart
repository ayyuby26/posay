// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:posay/features/intro/presentation/pages/intro_page.dart';
// import 'package:posay/features/intro/presentation/widgets/content.dart';
// // import 'package:posay/features/intro/presentation/screens/intro_screen.dart';

// void main() {
//   group('IntroScreen', ()   {
//     testWidgets('Page view and navigation', (WidgetTester tester) async {
//       WidgetsFlutterBinding.ensureInitialized();
//       await EasyLocalization.ensureInitialized();
//       await tester.pumpWidget(const IntroScreen());

//       // Perform assertions and interactions
//       // Test page view
//       expect(find.byType(PageView), findsOneWidget);
//       expect(find.byType(Content),
//           findsNWidgets(3)); // Assuming there are 3 Content widgets

//       // Test initial state
//       expect(find.text('finish'), findsNothing);
//       expect(find.text('next'), findsOneWidget);

//       // Test navigation
//       await tester.tap(find.text('next'));
//       await tester.pumpAndSettle();

//       expect(find.text('finish'), findsOneWidget);
//       expect(find.text('next'), findsNothing);

//       await tester.tap(find.text('finish'));
//       await tester.pumpAndSettle();

//       // Perform additional assertions as needed

//       // ...
//     });
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posay/shared/constants/constants.dart';
import 'package:posay/shared/constants/media_query_screen_size_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group("Constants Group", () {
    final query = MediaQueryScreenSizeProvider();
    final constants = Constants(screenSizeProvider: query);
    test('constants Test', () {
      expect(constants.edgesAll16, const EdgeInsets.all(16));
    });

    test("screenSize Test", () {
      final dd = constants.screenSize == constants.screenSize;
      expect(dd, false);
    });
  });
}

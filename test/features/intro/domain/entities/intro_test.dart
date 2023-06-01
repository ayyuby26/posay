import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';

import 'intro_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Intro>()])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test("Intro Entity Test", () {
    final intro = MockIntro();
    expect(intro.icon is IconData, true);
    expect(intro.desc, "");
  });
}

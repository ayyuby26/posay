
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posay/features/intro/domain/repositories/intro_repository.dart';
import 'package:posay/features/intro/domain/usecases/get_intro.dart';

import '../entities/intro_test.mocks.dart';
import 'intro_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IntroRepository>()])
void main() {
  final mock = MockIntroRepository();
  final intro = GetIntro(introRepository: mock);
  // intro.execute(appLocalizations)
}

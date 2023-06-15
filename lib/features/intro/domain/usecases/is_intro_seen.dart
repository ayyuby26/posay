import 'package:dartz/dartz.dart';
import 'package:posay/features/intro/domain/repositories/intro_repository.dart';
import 'package:posay/shared/failure.dart';

class IsIntroSeen {
  final IntroRepository introRepository;

  IsIntroSeen({required this.introRepository});

  Either<Failure, bool> execute() {
    return introRepository.isIntroSeen();
  }
}

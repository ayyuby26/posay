import 'package:dartz/dartz.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';
import 'package:posay/features/intro/domain/repositories/intro_repository.dart';
import 'package:posay/shared/failure.dart';

class SaveIntro {
  final IntroRepository introRepository;

  SaveIntro({required this.introRepository});

  Either<Failure, bool> execute(Intro intro) {
    return introRepository.saveIntro(intro);
  }
}

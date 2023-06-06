import 'package:dartz/dartz.dart';
import 'package:posay/features/auth/domain/repositories/user_repository.dart';
import 'package:posay/shared/failure.dart';

class Logout {
  final UserRepository userRepository;

  Logout({required this.userRepository});

  Either<Failure, int> execute() {
    return userRepository.logout();
  }
}

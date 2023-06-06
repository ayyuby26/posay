import 'package:dartz/dartz.dart';
import 'package:posay/shared/failure.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/features/auth/domain/repositories/user_repository.dart';

class Login {
  final UserRepository userRepository;

  Login({required this.userRepository});

  Future<Either<Failure, User>> execute(String username, String password) {
    return userRepository.login(username, password);
  }
}
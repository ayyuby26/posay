import 'package:dartz/dartz.dart';
import 'package:posay/shared/failure.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/features/auth/domain/repositories/user_repository.dart';

class GetLocalUser {
  final UserRepository userRepository;

  GetLocalUser({required this.userRepository});

  Either<Failure, User> execute() {
    return userRepository.getLocalUser();
  }
}

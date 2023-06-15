import 'package:dartz/dartz.dart';
import 'package:posay/shared/failure.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/features/auth/domain/repositories/user_repository.dart';

class SaveUserToLocalDb {
  final UserRepository userRepository;

  SaveUserToLocalDb({required this.userRepository});

  Either<Failure, int> execute(User user) {
    return userRepository.saveUserToLocalDb(user);
  }
}
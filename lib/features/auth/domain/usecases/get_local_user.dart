import 'package:posay/shared/failure.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/features/auth/domain/repositories/user_repository.dart';

class GetLocalUser {
  final UserRepository userRepository;

  GetLocalUser({required this.userRepository});

  (Failure, User) execute() {
    final (Failure, User) user = userRepository.getLocalUser();
    return user;
  }
}

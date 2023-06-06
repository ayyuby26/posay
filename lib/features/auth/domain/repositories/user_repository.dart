import 'package:dartz/dartz.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/shared/failure.dart';

abstract class UserRepository {
  Either<Failure, User> getLocalUser();
}

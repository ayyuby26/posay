import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/shared/failure.dart';

abstract class UserRepository {
  Either<Failure, User> getLocalUser();
  Either<Failure, int> saveUserToLocalDb(User user);
  Future<Either<Failure, User>> login(String username, String password, BuildContext context);
  Either<Failure, int> logout();
}

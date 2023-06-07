import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/features/auth/data/datasources/user_data_source.dart';
import 'package:posay/features/auth/data/models/user_model.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/failure.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserDataSource userDataSource;
  Box<UserModel> userModel;

  UserRepositoryImpl(this.userDataSource, this.userModel);

  @override
  Either<Failure, User> getLocalUser() {
    try {
      return Right(userDataSource.getLocalUser());
    } catch (e) {
      return const Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(
      String username, String password, BuildContext context) async {
    List<Map<String, dynamic>> users = [];

    try {
      users = await userDataSource.getUsers();
    } catch (e) {
      if (e is AppwriteException) return Left(ServerFailure(e.message));
      return Left(ServerFailure(e));
    }

    try {
      final user = await userDataSource.login(username, password, users);
      return Right(user.toEntity());
    } catch (e) {
      // ignore: use_build_context_synchronously
      return Left(DatabaseFailure(context.tr.userNotFound));
    }
  }

  @override
  Either<Failure, int> saveUserToLocalDb(User user) {
    try {
      return Right(userDataSource.saveUserToLocalDb(user));
    } catch (e) {
      return Left(LocalDatabaseFailure(e));
    }
  }

  @override
  Either<Failure, int> logout() {
    return Right(userModel.removeAll());
  }
}

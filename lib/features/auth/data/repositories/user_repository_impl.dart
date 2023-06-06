import 'package:dartz/dartz.dart';
import 'package:posay/features/auth/data/datasources/user_data_source.dart';
import 'package:posay/shared/failure.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserDataSource userDataSource;

  UserRepositoryImpl({required this.userDataSource});

  @override
  Either<Failure, User> getLocalUser() {
    try {
      return Right(userDataSource.getLocalUser());
    } catch (e) {
      return const Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      final result = await userDataSource.login(username, password);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(e));
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
}

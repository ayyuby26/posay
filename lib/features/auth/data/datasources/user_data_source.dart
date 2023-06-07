import 'package:appwrite/appwrite.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/core/db_constants_id.dart';
import 'package:posay/features/auth/data/models/user_model.dart';
import 'package:posay/features/auth/domain/entities/user.dart';
import 'package:posay/shared/failure.dart';

abstract class UserDataSource {
  User getLocalUser();
  int saveUserToLocalDb(User user);
  Future<UserModel> login(String username, String password);
}

class UserDataSourceImpl extends UserDataSource {
  Databases databases;
  Box<UserModel> userModel;

  UserDataSourceImpl(this.userModel, this.databases);

  @override
  User getLocalUser() {
    return userModel.getAll().first.toEntity();
  }

  @override
  Future<UserModel> login(String username, String password) async {
    final getUsers = await databases.listDocuments(
      databaseId: DbConstantsId.databaseId,
      collectionId: DbConstantsId.authId,
    );

    try {
      final isFound = getUsers.documents.firstWhere((e) =>
          e.data['username'] == username && e.data['password'] == password);

      return UserModel(
        username: username,
        password: password,
        name: isFound.data['name'],
      );
    } catch (e) {
      throw const DatabaseFailure();
    }
  }

  @override
  int saveUserToLocalDb(User user) {
    return userModel.put(user.toEntity);
  }
}

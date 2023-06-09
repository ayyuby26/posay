import 'package:appwrite/appwrite.dart';

import 'package:objectbox/objectbox.dart';
import 'package:posay/core/db_constants_id.dart';
import 'package:posay/features/auth/data/models/user_model.dart';
import 'package:posay/features/auth/domain/entities/user.dart';

abstract class UserDataSource {
  User getLocalUser();
  int saveUserToLocalDb(User user);
  Future<UserModel> login(
    String username,
    String password,
    List<Map<String, dynamic>> users,
  );
  Future<List<Map<String, dynamic>>> getUsers();
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
  Future<UserModel> login(
    String username,
    String password,
    List<Map<String, dynamic>> users,
  ) async {
    final user = users.firstWhere(
        (e) => e['username'] == username && e['password'] == password);

    return UserModel(
      username: username,
      password: password,
      name: user['name'],
    );
  }

  @override
  int saveUserToLocalDb(User user) {
    return userModel.put(user.toModel);
  }

  @override
  Future<List<Map<String, dynamic>>> getUsers() async {
    final users = await databases.listDocuments(
      databaseId: DbConstantsId.databaseId,
      collectionId: DbConstantsId.authId,
    );
    return users.documents.map((e) => e.data).toList();
  }
}

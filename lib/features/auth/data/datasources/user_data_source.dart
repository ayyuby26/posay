import 'package:objectbox/objectbox.dart';
import 'package:posay/features/auth/data/models/user_model.dart';
import 'package:posay/features/auth/domain/entities/user.dart';

abstract class UserDataSource {
  User getLocalUser();
}

class UserDataSourceImpl extends UserDataSource {
  Box<UserModel> userModel;

  UserDataSourceImpl(this.userModel);
  
  @override
  User getLocalUser() {
    return userModel.getAll().first.toEntity();
  }
}

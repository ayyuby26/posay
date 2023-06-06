import 'package:objectbox/objectbox.dart';
import 'package:posay/shared/failure.dart';
import 'package:posay/features/auth/data/models/user_model.dart';
import 'package:posay/features/auth/domain/entities/user.dart';

abstract class UserDataSource {
  (Failure, User) getLocalUser();
}

class UserDataSourceImpl extends UserDataSource {
  Box<UserModel> userModel;
  UserDataSourceImpl(this.userModel);
  @override
  (Failure, User) getLocalUser() {
    late Failure failure;
    late User user;
    try {
      final result = userModel.getAll();
      if (result.isNotEmpty) {
        user = result.first.toEntity();
      }
    } catch (e) {
      failure = LocalDatabaseFailure(e.toString());
    }
    return (failure, user);
  }
}

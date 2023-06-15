import 'package:objectbox/objectbox.dart';
import 'package:posay/features/auth/domain/entities/user.dart';

@Entity()
class UserModel {
  int id = 0;

  String username;
  String password;
  String name;

  UserModel({
    required this.username,
    required this.password,
    required this.name,
  });

  User toEntity() {
    return User(
      username: username,
      password: password,
      name: name,
    );
  }
}

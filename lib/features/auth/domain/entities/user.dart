import 'package:equatable/equatable.dart';
import 'package:posay/features/auth/data/models/user_model.dart';

class User extends Equatable {
  final String username;
  final String password;
  final String name;

  const User({
    required this.username,
    required this.password,
    required this.name,
  });

  UserModel get toEntity {
    return UserModel(
      username: username,
      password: password,
      name: name,
    );
  }

  @override
  List<Object> get props => [username, password, name];
}

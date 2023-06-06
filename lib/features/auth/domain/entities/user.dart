import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String password;
  final String name;

  const User({
    required this.username,
    required this.password,
    required this.name,
  });

  @override
  List<Object> get props => [username, password, name];
}

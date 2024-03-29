import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class InitFailure extends Failure {
  const InitFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure([data]) : super('$data');
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([String? message]) : super(message ?? "");
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure([data]) : super('$data');
}

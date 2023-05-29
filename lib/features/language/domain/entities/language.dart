import 'package:equatable/equatable.dart';

class Language extends Equatable {
  const Language({
    required this.code,
    required this.name,
  });

  final String code;
  final String name;

  @override
  List<Object> get props => [code, name];
}

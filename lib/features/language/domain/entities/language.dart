import 'package:equatable/equatable.dart';
import 'package:posay/features/language/data/models/language_model.dart';

class Language extends Equatable {
  const Language({
    required this.code,
    required this.name,
  });

  final String code;
  final String name;

  LanguageModel toModel() {
    return LanguageModel(code: code, name: name);
  }

  @override
  List<Object> get props => [code, name];
}

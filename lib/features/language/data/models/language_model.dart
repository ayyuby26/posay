import 'package:objectbox/objectbox.dart';
import 'package:posay/features/language/domain/entities/language.dart';

@Entity()
class LanguageModel {
  int id = 0;

  String code;
  String name;
  LanguageModel({required this.code, required this.name});

  Language toEntity() {
    return Language(code: code, name: name);
  }
}

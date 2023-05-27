import 'package:objectbox/objectbox.dart';

@Entity()
class LanguageModel {
  int id = 0;

  String code;
  String name;
  LanguageModel({required this.code, required this.name});
}

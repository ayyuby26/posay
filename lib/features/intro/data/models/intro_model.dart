import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';

@Entity()
class IntroModel {
  int id = 0;

  final int iconCodePoint;
  final String desc;

  IntroModel({required this.iconCodePoint, required this.desc});

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');

  factory IntroModel.fromEntity(Intro intro) {
    return IntroModel(iconCodePoint: intro.icon.codePoint, desc: intro.desc);
  }

  Intro toEntity() {
    return Intro(icon: icon, desc: desc);
  }
}

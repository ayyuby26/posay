import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:posay/features/intro/data/models/intro_model.dart';

class Intro extends Equatable {
  final IconData icon;
  final String desc;

  const Intro({
    required this.icon,
    required this.desc,
  });
  IntroModel get toModel {
    return IntroModel(
      iconCodePoint: icon.codePoint,
      desc: desc,
    );
  }

  @override
  List<Object> get props => [icon, desc];
}

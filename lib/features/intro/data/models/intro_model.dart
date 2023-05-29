import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';

class IntroModel extends Equatable {
  final IconData icon;
  final String desc;

  const IntroModel({required this.icon, required this.desc});

  Intro toEntity() {
    return Intro(icon: icon, desc: desc);
  }

  @override
  List<Object> get props => [icon, desc];
}

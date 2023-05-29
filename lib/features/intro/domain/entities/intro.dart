import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Intro extends Equatable {
  final IconData icon;
  final String desc;

  const Intro({
    required this.icon,
    required this.desc,
  });
  
  @override
  List<Object> get props => [icon, desc];
}

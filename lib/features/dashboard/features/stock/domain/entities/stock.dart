import 'dart:core';
import 'dart:core' as x;

import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String name;
  final String code;
  final int total;
  final String unit;
  final x.double price; 
  final DateTime stockIn;
  final DateTime? expired;
  final String currency;

  const Stock({
    required this.name,
    required this.code,
    required this.total,
    required this.unit,
    required this.price, 
    required this.stockIn,
      this.expired,
    required this.currency,
  });

  @override
  List<Object?> get props => [
        name,
        code,
        total,
        unit,
        price,
        double,
        stockIn,
        expired,
        currency,
      ];
}

import 'dart:core';
import 'dart:core' as x;
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
part 'stock_model.g.dart';

@JsonSerializable()
@Entity()
class StockModel {
  int id = 0;
  final String name;
  final String code;
  @Property(uid: 8658536853573444526)
  final int total;
  final String unit;
  final x.double price;
  final DateTime stockIn;
  final DateTime? expired;
  final String currency;

  StockModel({
    required this.name,
    required this.code,
    required this.total,
    required this.unit,
    required this.price,
    required this.stockIn,
    this.expired,
    required this.currency,
  });

  Stock toEntity() {
    return Stock(
      name: name,
      code: code,
      total: total,
      unit: unit,
      price: price,
      stockIn: stockIn,
      expired: expired,
      currency: currency,
    );
  }

  factory StockModel.fromJson(Map<String, dynamic> json) =>
      _$StockModelFromJson(json);
}

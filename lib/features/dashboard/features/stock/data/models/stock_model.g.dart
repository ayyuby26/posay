// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockModel _$StockModelFromJson(Map<String, dynamic> json) => StockModel(
      name: json['name'] as String,
      code: json['code'] as String,
      total: json['total'] as int,
      unit: json['unit'] as String,
      price: (json['price'] as num).toDouble(),
      stockIn: DateTime.parse(json['stockIn'] as String),
      expired: json['expired'] == null
          ? null
          : DateTime.parse(json['expired'] as String),
      currency: json['currency'] as String,
      documentId: '',
    );

Map<String, dynamic> _$StockModelToJson(StockModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'total': instance.total,
      'unit': instance.unit,
      'price': instance.price,
      'stockIn': instance.stockIn.toIso8601String(),
      'expired': instance.expired?.toIso8601String(),
      'currency': instance.currency,
    };

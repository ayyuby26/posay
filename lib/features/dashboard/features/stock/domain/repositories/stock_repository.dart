import 'package:dartz/dartz.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/shared/failure.dart';

abstract class StockRepository {
  Future<Either<Failure, List<Stock>>> getStockList({
    int currLength,
    String search,
  });
  Future<Either<Failure, Stock>> addStock(Stock stock);
  Future<Either<Failure, Map<String, dynamic>>> updateStock(Stock stock);
  Future<Either<Failure, dynamic>> deleteStock(String documentId);
}

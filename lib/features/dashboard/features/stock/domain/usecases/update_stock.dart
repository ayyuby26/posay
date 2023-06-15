import 'package:dartz/dartz.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/repositories/stock_repository.dart';
import 'package:posay/shared/failure.dart';

class UpdateStock {
  final StockRepository stockRepository;

  UpdateStock({required this.stockRepository});

  Future<Either<Failure, Map<String, dynamic>>> execute(Stock stock) async {
    return stockRepository.updateStock(stock);
  }
}

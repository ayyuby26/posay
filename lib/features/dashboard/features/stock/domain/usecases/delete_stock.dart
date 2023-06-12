import 'package:dartz/dartz.dart';
import 'package:posay/features/dashboard/features/stock/domain/repositories/stock_repository.dart';
import 'package:posay/shared/failure.dart';

class DeleteStock {
  final StockRepository stockRepository;

  DeleteStock({required this.stockRepository});

  Future<Either<Failure, dynamic>> execute(String databaseId) async {
    return stockRepository.deleteStock(databaseId);
  }
}

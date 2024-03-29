import 'package:dartz/dartz.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/repositories/stock_repository.dart';
import 'package:posay/shared/failure.dart';

class AddStock {
  final StockRepository stockRepository;

  AddStock({required this.stockRepository});

  Future<Either<Failure, Stock>> execute(Stock stock) async {
    return stockRepository.addStock(stock);
  }
}

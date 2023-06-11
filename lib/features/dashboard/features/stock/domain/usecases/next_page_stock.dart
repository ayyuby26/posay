import 'package:dartz/dartz.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/repositories/stock_repository.dart';
import 'package:posay/shared/failure.dart';

class NextPageStock {
  final StockRepository stockRepository;

  NextPageStock({required this.stockRepository});

  Future<Either<Failure, List<Stock>>> execute(int currLength) async {
    return stockRepository.getStockList(currLength: currLength);
  }
}

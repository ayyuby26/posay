import 'package:dartz/dartz.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/repositories/stock_repository.dart';
import 'package:posay/shared/failure.dart';

class SearchStock {
  final StockRepository stockRepository;

  SearchStock({required this.stockRepository});

  Future<Either<Failure, List<Stock>>> execute(String search) async {
    return stockRepository.getStockList(search: search);
  }
}

import 'package:dartz/dartz.dart';
import 'package:posay/features/dashboard/features/stock/data/datasources/stock_data_source.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/features/dashboard/features/stock/domain/repositories/stock_repository.dart';
import 'package:posay/shared/failure.dart';

class StockRepositoryImpl implements StockRepository {
  final StockDataSource stockDataSource;
  StockRepositoryImpl(this.stockDataSource);

  @override
  Future<Either<Failure, List<Stock>>> getStockList() async {
    try {
      final result = await stockDataSource.getStockList();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }
}

import 'package:appwrite/appwrite.dart';
import 'package:posay/core/db_constants_id.dart';
import 'package:posay/features/dashboard/features/stock/data/models/stock_model.dart';

abstract class StockDataSource {
  Future<List<StockModel>> getStockList();
}

class StockDataSourceImpl extends StockDataSource {
  final Databases databases;

  StockDataSourceImpl(this.databases);

  @override
  Future<List<StockModel>> getStockList() async {
    final stockList = await databases.listDocuments(
      databaseId: DbConstantsId.databaseId,
      collectionId: DbConstantsId.stockId,
    );
    return stockList.documents.map((e) => StockModel.fromJson(e.data)).toList();
  }
}

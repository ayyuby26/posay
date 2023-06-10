import 'package:appwrite/appwrite.dart';
import 'package:posay/core/db_constants_id.dart';
import 'package:posay/features/dashboard/features/stock/data/models/stock_model.dart';

abstract class StockDataSource {
  Future<List<StockModel>> getStockList(int currLength);
  Future<StockModel> addStock(StockModel stock);
}

class StockDataSourceImpl extends StockDataSource {
  final Databases databases;

  StockDataSourceImpl(this.databases);

  @override
  Future<List<StockModel>> getStockList(int currLength) async {
    final stockList = await databases.listDocuments(
      databaseId: DbConstantsId.databaseId,
      collectionId: DbConstantsId.stockId,
      queries: [
        if (!currLength.isNegative) Query.offset(currLength),
      ],
    );

    return stockList.documents
        .map((e) => StockModel.fromJson(e.data)..databaseId = e.$databaseId)
        .toList();
  }

  @override
  Future<StockModel> addStock(StockModel stock) async {
    final create = await databases.createDocument(
      databaseId: DbConstantsId.databaseId,
      collectionId: DbConstantsId.stockId,
      data: stock.toJson(),
      documentId: ID.unique(),
    );

    return StockModel.fromJson(create.data);
  }
}

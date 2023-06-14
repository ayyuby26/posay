import 'package:appwrite/appwrite.dart';
import 'package:posay/core/db_constants_id.dart';
import 'package:posay/features/dashboard/features/stock/data/models/stock_model.dart';

abstract class StockDataSource {
  Future<List<StockModel>> getStockList({
    int currLength = -1,
    String search = '',
  });
  Future<StockModel> addStock(StockModel stock);
  Future<Map<String, dynamic>> updateStock(StockModel stock);
  Future<dynamic> deleteStock(String documentId);
}

class StockDataSourceImpl extends StockDataSource {
  final Databases databases;

  StockDataSourceImpl(this.databases);

  @override
  Future<List<StockModel>> getStockList({
    int currLength = -1,
    String search = '',
  }) async {
    final stockList = await databases.listDocuments(
      databaseId: DbConstantsId.databaseId,
      collectionId: DbConstantsId.stockId,
      queries: [
        if (!currLength.isNegative) Query.offset(currLength),
        if (search.isNotEmpty) ...[
          Query.equal('name', search),
        ]
      ],
    );

    return stockList.documents
        .map((e) => StockModel.fromJson(e.data)..documentId = e.$id)
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

  @override
  Future deleteStock(String documentId) async {
    return await databases.deleteDocument(
      databaseId: DbConstantsId.databaseId,
      collectionId: DbConstantsId.stockId,
      documentId: documentId,
    );
  }

  @override
  Future<Map<String, dynamic>> updateStock(StockModel stock) async {
    final response = await databases.updateDocument(
      databaseId: DbConstantsId.databaseId,
      collectionId: DbConstantsId.stockId,
      documentId: stock.documentId,
      data: stock.toJson(),
    );

    return response.data;
  }
}

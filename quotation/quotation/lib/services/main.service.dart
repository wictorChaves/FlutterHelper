import 'package:quotation/database/db.dart';
import 'package:quotation/models/quotation.model.dart';
import 'package:sqflite/sqflite.dart';

class MainService {
  DBService databaseService;
  String dataBaseName = "";

  MainService(String datadaseName) {
    dataBaseName = datadaseName;
    databaseService = DBService();
  }

  Future<List<Quotation>> GetAll() async {
    return await databaseService.Transaction<List<Quotation>>(
        (DatabaseExecutor txn) async {
      List<Map> mapList = await txn.rawQuery(
          "SELECT * FROM " + dataBaseName);
      return List<Quotation>.of(mapList.map((item) {
        return Quotation.fromJson(item);
      }));
    });
  }

  Future<Quotation> GetById(int id) async {
    return await databaseService.Transaction<Quotation>(
        (DatabaseExecutor txn) async {
      List<Map<String, dynamic>> mapList =
          await txn.query(dataBaseName, where: "id = ?", whereArgs: [id]);
      if (mapList.length <= 0) return null;
      return Quotation.fromJson(mapList[0]);
    });
  }

  Future<int> Add(Quotation Quotation) async {
    return await databaseService.Transaction<int>(
        (DatabaseExecutor txn) async {
      return await txn.insert(dataBaseName, Quotation.toJson());
    });
  }

  Future<int> Update(Quotation Quotation) async {
    return await databaseService.Transaction<int>(
        (DatabaseExecutor txn) async {
      return await txn.update(dataBaseName, Quotation.toJson(),
          where: "id = ?", whereArgs: [Quotation.id]);
    });
  }

  Future<int> Delete(int id) async {
    return await databaseService.Transaction<int>(
        (DatabaseExecutor txn) async {
      return await txn.delete(dataBaseName, where: "id = " + id.toString());
    });
  }
}

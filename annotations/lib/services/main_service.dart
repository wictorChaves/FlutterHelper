import 'package:annotations/model/annotation.dart';
import 'package:annotations/services/db_service.dart';
import 'package:sqflite/sqflite.dart';

class MainService {
  DBService _databaseService;
  String _dataBaseName = "";

  MainService(String dataBaseName) {
    _dataBaseName = dataBaseName;
    _databaseService = DBService();
  }

  Future<List<Annotation>> GetAll() async {
    return await _databaseService.Transaction<List<Annotation>>(
        (DatabaseExecutor txn) async {
      List<Map> mapList = await txn.rawQuery("SELECT * FROM " + _dataBaseName);
      return List<Annotation>.of(mapList.map((item) {
        return Annotation.fromJson(item);
      }));
    });
  }

  Future<Annotation> GetById(int id) async {
    return await _databaseService.Transaction<int>(
        (DatabaseExecutor txn) async {
      List<Map<String, dynamic>> mapList =
          await txn.query(_dataBaseName, where: "id = ?", whereArgs: [id]);
      if (mapList.length <= 0) return null;
      return Annotation.fromJson(mapList[0]);
    });
  }

  Future<int> Add(Annotation annotation) async {
    return await _databaseService.Transaction<int>(
        (DatabaseExecutor txn) async {
      return await txn.insert(_dataBaseName, annotation.toJson());
    });
  }

  Future<int> Update(Annotation annotation) async {
    return await _databaseService.Transaction<int>(
        (DatabaseExecutor txn) async {
      return await txn.update(_dataBaseName, annotation.toJson());
    });
  }

  Future<int> Delete(int id) async {
    return await _databaseService.Transaction<int>(
        (DatabaseExecutor txn) async {
      return await txn.delete(_dataBaseName, where: "id = " + id.toString());
    });
  }
}

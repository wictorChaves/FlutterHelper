import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../configs.dart';

class DBService {
  Future<String> GetPath() async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, DB_FILE_NAME);
  }

  Future<Database> GetDatabase() async {
    return await openDatabase(await GetPath(), version: DB_VERSION,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE annotation (id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR, content TEXT, create_datetime datetime, update_datetime datetime)');
    });
  }

  Future<void> DeleteDatabase() async {
    return await deleteDatabase(await GetPath());
  }

  Transaction<T>(Function func) async {
    T result;
    Database database = await GetDatabase();
    await database.transaction((txn) async => result = await func(txn));
    return result;
  }
}

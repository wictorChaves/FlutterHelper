import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  Database _database;
  String DB_FILE_NAME = "data.db";
  int DB_VERSION = 4;

  static final DBService _singleton = DBService._internal();

  DBService._internal();

  factory DBService() {
    return _singleton;
  }

  Future<String> GetPath() async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, 'DB_FILE_NAME');
  }

  Future<Database> GetDatabase() async {
    return _database = (_database == null)
        ? await openDatabase(await GetPath(),
            version: DB_VERSION, onCreate: _onCreate)
        : _database;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE quotation (id INTEGER PRIMARY KEY AUTOINCREMENT, currencyfrom VARCHAR, currencyto VARCHAR, value REAL, currencygroup VARCHAR)');
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

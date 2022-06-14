import 'package:quotation/models/quotation.model.dart';
import 'package:sqflite/sqflite.dart';

import 'main.service.dart';

class QuotationService extends MainService {
  static final QuotationService _singleton = QuotationService._internal();

  QuotationService._internal() : super("quotation");

  factory QuotationService() {
    return _singleton;
  }

  Future<Quotation> Get(String from, String to, String group) async {
    return await databaseService.Transaction<Quotation>(
        (DatabaseExecutor txn) async {
      List<Map<String, dynamic>> mapList = await txn.query(dataBaseName,
          where: "currencyfrom = ? AND currencyto = ? AND currencygroup = ?",
          whereArgs: [from, to, group]);
      if (mapList.length <= 0) return null;
      return Quotation.fromJson(mapList[0]);
    });
  }

  Future<int> UpdateWithoutId(Quotation Quotation) async {
    return await databaseService.Transaction<int>((DatabaseExecutor txn) async {
      return await txn.update(dataBaseName, Quotation.toJsonWithoutId(),
          where: "currencyfrom = ? AND currencyto = ? AND currencygroup = ?",
          whereArgs: [Quotation.currencyfrom, Quotation.currencyto, Quotation.currencygroup]);
    });
  }
}

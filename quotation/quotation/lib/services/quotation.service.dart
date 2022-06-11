import 'package:quotation/models/quotation.model.dart';
import 'package:sqflite/sqflite.dart';

import 'main.service.dart';

class QuotationService extends MainService {
  static final QuotationService _singleton = QuotationService._internal();

  QuotationService._internal() : super("quotation");

  factory QuotationService() {
    return _singleton;
  }

  Future<Quotation> Get(String from, String to) async {
    return await databaseService.Transaction<Quotation>((DatabaseExecutor txn) async {
      List<Map<String, dynamic>> mapList = await txn.query(dataBaseName,
          where: "currencyfrom = ? AND currencyto = ?", whereArgs: [from, to]);
      if (mapList.length <= 0) return null;
      return Quotation.fromJson(mapList[0]);
    });
  }
}

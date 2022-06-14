import 'dart:convert';
import 'package:quotation/helper/currency.helper.dart';
import 'package:http/http.dart' as http;

class AskingPriceService {
  var coinsQuotation = [
    'BRL-USD',
    'BRL-ARS',
    'ARS-USD',
    'ARS-BRL',
    'USD-BRL',
    'USD-ARS'
  ];

  Future<http.Response> getQuotation(String coinsQuotation) {
    return http.get(
        Uri.parse('https://economia.awesomeapi.com.br/last/' + coinsQuotation));
  }

  Future<double> get(String from, String to) async {
    var coinQuotation = from + '-' + to;
    final response = await getQuotation(coinQuotation);
    if (response.statusCode == 200) {
      Map obj = json.decode(response.body);
      var askingPrice = obj[coinQuotation]['bid'];
      return CurrencyHelper.toDouble(askingPrice);
    }
    return 0.0;
  }

  Future<Map> getAll() async {
    final response = await getQuotation(coinsQuotation.join(','));
    var newMap = getNewMap();
    if (response.statusCode == 200) {
      Map obj = json.decode(response.body);
      coinsQuotation.forEach((element) {
        var key = element.replaceAll('-', '');
        newMap[element] = CurrencyHelper.toDouble(obj[key]['bid']);
      });
      return newMap;
    }
    return newMap;
  }

  getNewMap() {
    Map newObj = new Map();
    coinsQuotation.forEach((element) {
      newObj[element] = 0.0;
    });
    return newObj;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/helper/currency.helper.dart';
import 'package:quotation/models/quotation.model.dart';
import 'package:quotation/services/quotation.service.dart';
import '../main-helper.dart';
import 'internal-configs.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  QuotationService _quotationService = new QuotationService();
  List<Quotation> _dbQuotations = [];
  var _controllers = {
    'BRL': {
      'USD': new TextEditingController(),
      'ARS': new TextEditingController()
    },
    'ARS': {
      'USD': new TextEditingController(),
      'BRL': new TextEditingController()
    },
    'USD': {
      'BRL': new TextEditingController(),
      'ARS': new TextEditingController()
    }
  };
  var _currencies = {
    'BRL': {'USD': 0.21, 'ARS': 24.41},
    'ARS': {'USD': 0.0082, 'BRL': 0.041},
    'USD': {'BRL': 4.99, 'ARS': 121.78}
  };

  @override
  Future<void> initState() {
    super.initState();
    loadRecords();
  }

  loadRecords() {
    _quotationService.GetAll().then((values) {
      _dbQuotations = values == null ? [] : values;
      setCurrencies('BRL', 'USD');
      setCurrencies('BRL', 'ARS');

      setCurrencies('ARS', 'USD');
      setCurrencies('ARS', 'BRL');

      setCurrencies('USD', 'BRL');
      setCurrencies('USD', 'ARS');
    });
  }

  setCurrencies(from, to) {
    var dbQuotation = _dbQuotations.firstWhere(
        (x) => x.currencyfrom == from && x.currencyto == to,
        orElse: () => null);
    _controllers[from][to].text =
        dbQuotation == null ? '0' : dbQuotation.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: InternalConfigs.PRIMARYCOLOR,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 0),
                child: Text(
                  'BRL',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('USD', textAlign: TextAlign.center)),
                    Expanded(child: Text('ARS', textAlign: TextAlign.center))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _controllers['BRL']['USD'],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: ''),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controllers['BRL']['ARS'],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: ''),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 0),
                child: Text(
                  'ARS',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('USD', textAlign: TextAlign.center)),
                    Expanded(child: Text('BRL', textAlign: TextAlign.center))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _controllers['ARS']['USD'],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: ''),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controllers['ARS']['BRL'],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: ''),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 0),
                child: Text(
                  'USD',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('BRL', textAlign: TextAlign.center)),
                    Expanded(child: Text('ARS', textAlign: TextAlign.center))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _controllers['USD']['BRL'],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: ''),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controllers['USD']['ARS'],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: ''),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  padding: EdgeInsets.all(15),
                  color: InternalConfigs.PRIMARYCOLOR,
                  child: Text(
                    "Salvar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    saveCurrencies().then((value) {
                      Helper.dialog(context, 'title', 'content');
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveCurrencies() async {
    await saveCurrency('BRL', 'USD');
    await saveCurrency('BRL', 'ARS');

    await saveCurrency('ARS', 'USD');
    await saveCurrency('ARS', 'BRL');

    await saveCurrency('USD', 'BRL');
    await saveCurrency('USD', 'ARS');

    loadRecords();
  }

  saveCurrency(from, to) async {
    double value = CurrencyHelper.toDouble(_controllers[from][to].text);

    var quotation = _dbQuotations.firstWhere(
        (quotation) =>
            quotation.currencyfrom == from && quotation.currencyto == to,
        orElse: () => null);

    if (quotation == null) {
      await _quotationService.Add(new Quotation.New(from, to, value, '1'));
    } else {
      quotation.value = value;
      await _quotationService.Update(quotation);
    }
  }
}

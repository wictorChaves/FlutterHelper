import 'package:flutter/material.dart';
import 'package:quotation/helper/currency.helper.dart';
import 'package:quotation/models/quotation.model.dart';
import 'package:quotation/services/quotation.service.dart';
import 'package:quotation/view/settings/internal-configs.dart';
import 'package:quotation/view/settings/settings.dart';
import '../calcquotation/calc-quotation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  QuotationService _quotationService = new QuotationService();
  List<Quotation> _dbQuotations = [];
  TextEditingController valueController = TextEditingController();
  var _values = {
    'BRL': {'USD': 0.20, 'ARS': 24.41},
    'ARS': {'USD': 0.0082, 'BRL': 0.041},
    'USD': {'BRL': 4.99, 'ARS': 121.78}
  };
  var _currencies = {
    'BRL': {'USD': 0.20, 'ARS': 24.41},
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
    _values[from][to] = dbQuotation == null ? 0.0 : dbQuotation.value;
    _currencies[from][to] = dbQuotation == null ? 0.0 : dbQuotation.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(InternalConfigs.APPTITLE),
          backgroundColor: InternalConfigs.PRIMARYCOLOR,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'Settings':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Settings()),
                    ).then((value) {
                      calculateQuotation(valueController.text);
                      loadRecords();
                    } );
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ]),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: valueController,
                        onChanged: calculateQuotation,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(labelText: "Entre com o valor")),
                  ),
                ],
              ),
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
                      child: Text(
                        _values['BRL']['USD'].toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _values['BRL']['ARS'].toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )
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
                      child: Text(
                        _values['ARS']['USD'].toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _values['ARS']['BRL'].toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
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
                      child: Text(
                        _values['USD']['BRL'].toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _values['USD']['ARS'].toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0),
                child: Image(image: AssetImage("images/logo.png")),
              )
            ],
          ),
        ),
      ),
    );
  }

  calculateQuotation(text) {
    var value = CurrencyHelper.toDouble(text);
    var calcQuotation = new CalcQuotation(_currencies);
    calcQuotation.setValue(value);

    setState(() {
      _values['BRL']['USD'] = calcQuotation.toUSD('BRL');
      _values['BRL']['ARS'] = calcQuotation.toARS('BRL');

      _values['ARS']['USD'] = calcQuotation.toUSD('ARS');
      _values['ARS']['BRL'] = calcQuotation.toBRL('ARS');

      _values['USD']['BRL'] = calcQuotation.toBRL('USD');
      _values['USD']['ARS'] = calcQuotation.toARS('USD');
    });
  }
}

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
  TextEditingController valueController = TextEditingController(text: '1');
  List<Quotation> _quotations;

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

  String selectedGroup = 'Commercial';
  List<String> groupList = ['Commercial'];

  Future<void> loadRecords() async {
    _quotations = await _quotationService.GetAll();
    setValues();
  }

  setValues() {
    setState(() {
      setGroups();
      loadCurrencies();
      calculateQuotation(valueController.text);
    });
  }

  setGroups() {
    groupList = _quotations.map((e) => e.currencygroup).toSet().toList();
  }

  loadCurrencies() {
    setCurrencies('BRL', 'USD');
    setCurrencies('BRL', 'ARS');

    setCurrencies('ARS', 'USD');
    setCurrencies('ARS', 'BRL');

    setCurrencies('USD', 'BRL');
    setCurrencies('USD', 'ARS');
  }

  setCurrencies(String from, String to) {
    var quotation = getQuotation(from, to);
    _currencies[from][to] = quotation == null ? 0.0 : quotation.value;
  }

  getQuotation(from, to) {
    return _quotations.firstWhere(
        (quotation) =>
            quotation.currencyfrom == from &&
            quotation.currencyto == to &&
            quotation.currencygroup == selectedGroup,
        orElse: () => null);
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
                      setState(() {
                        loadRecords();
                      });
                    });
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
              DropdownButton<String>(
                value: selectedGroup,
                onChanged: (String newValue) {
                  setState(() {
                    selectedGroup = newValue;
                    loadRecords().then((value) {
                      calculateQuotation(valueController.text);
                    });
                  });
                },
                items: groupList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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

}

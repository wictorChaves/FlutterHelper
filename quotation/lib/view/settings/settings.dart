import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/models/quotation.model.dart';
import 'package:quotation/services/quotation.service.dart';
import 'package:quotation/view/settings/settings-form.dart';
import '../helper.dart';
import 'internal-configs.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  QuotationService _quotationService = new QuotationService();
  SettingsForm _form = new SettingsForm();
  List<Quotation> _dbQuotations = [];

  @override
  Future<void> initState() {
    super.initState();
    loadRecords();
  }

  Future<void> loadRecords() async {
    await loadDBQuotation();
    setState(() {
      _form.setValues(_dbQuotations);
    });
  }

  loadDBQuotation() async {
    var values = await _quotationService.GetAll();
    _dbQuotations = values == null ? [] : values;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(
              controller: _form.controllers['group'],
              decoration: InputDecoration(hintText: "Nome da nova cotação"),
            ),
            actions: <Widget>[
              FlatButton(
                color: InternalConfigs.PRIMARYCOLOR,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    _form.addNewQuotation().then((value) {
                      setState(() {
                        loadRecords();
                      });
                    });
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
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
              DropdownButton<String>(
                value: _form.selectedGroup,
                onChanged: (String newValue) {
                  setState(() {
                    _form.selectedGroup = newValue;
                    loadRecords().then((value) {});
                  });
                },
                items: _form.groupList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  color: Colors.transparent,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text("+ Adicionar contação",
                          style:
                              TextStyle(color: InternalConfigs.PRIMARYCOLOR))),
                  onPressed: () {
                    _displayTextInputDialog(context);
                  },
                ),
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
                      child: TextField(
                        controller: _form.controllers['BRL-USD'],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: ''),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _form.controllers['BRL-ARS'],
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
                        controller: _form.controllers['ARS-USD'],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: ''),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _form.controllers['ARS-BRL'],
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
                        controller: _form.controllers['USD-BRL'],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: ''),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _form.controllers['USD-ARS'],
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
                    _form.saveCurrencies(_dbQuotations).then((value) {
                      Helper.dialog(
                          context, 'Tudo certo!', 'Nova cotação salva :)');
                      loadRecords();
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
}

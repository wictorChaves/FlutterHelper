import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _url = "https://blockchain.info/ticker";
  var _value = "Carregando...";

  _HomeState() {
    _reloadPrice();
  }

  _reloadPrice() async {
    _value = "Carregando...";
    final response = await http.get(_url);
    print(response.body);
    if (response.statusCode == 200) {
      Map obj = json.decode(response.body);
      setState(() {
        _value = "R\$ " + obj["BRL"]["last"].toString().replaceAll(".", ",");
      });
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _padding = 8.0;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/bitcoin.png"),
            Padding(padding: EdgeInsets.all(_padding)),
            Text(
              "$_value",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.all(_padding)),
            RaisedButton(
              color: Colors.orange,
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text(
                "Atualizar",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: _reloadPrice,
            )
          ],
        ),
      ),
    );
  }
}

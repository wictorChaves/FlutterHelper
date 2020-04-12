import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _frase = [
    "1 - Gratidão não é pagamento, mas um reconhecimento que se demonstra no dia a dia.",
    "2 - Gratidão não é pagamento, mas um reconhecimento que se demonstra no dia a dia.",
    "3 - Gratidão não é pagamento, mas um reconhecimento que se demonstra no dia a dia."
  ];
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Frases do dia")),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("images/logo.png"),
            Text(_frase[_index], textAlign: TextAlign.justify),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _index = Random().nextInt(3);
                });
              },
              child: Text(
                "Nova frase",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}

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
    "Sou apenas um pequeno planeta que se perde diariamente em todo o seu universo.",
    "Novas amizades serão sempre bem-vindas para darem cor e alegria ao meu dia a dia.",
    "Gratidão não é pagamento, mas um reconhecimento que se demonstra no dia a dia.",
    "Nem toda mudança importante acontece de repente e faz barulho, algumas são silenciosas e vão se fazendo no dia a dia."
  ];
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frases do dia"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("images/logo.png"),
            Text(
                _frase[_index],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 22
                ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _index = Random().nextInt(_frase.length);
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

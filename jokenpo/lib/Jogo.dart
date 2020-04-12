import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  @override
  Widget build(BuildContext context) {
    var _imageSize = 80.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Escolha do App:"),
            Image.asset("images/papel.png"),
            Text("Você perdeu :("),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    print("pedra");
                  },
                  child: Image.asset("images/pedra.png", width: _imageSize),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    print("papel");
                  },
                  child: Image.asset("images/papel.png", width: _imageSize),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    print("tesoura");
                  },
                  child: Image.asset("images/tesoura.png", width: _imageSize),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

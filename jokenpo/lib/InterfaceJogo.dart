import 'package:flutter/material.dart';

import 'Jogo.dart';

class InterfaceJogo extends StatefulWidget {
  @override
  _InterfaceJogoState createState() => _InterfaceJogoState();
}

class _InterfaceJogoState extends State<InterfaceJogo> {
  var _imagemApp = AssetImage("images/padrao.png");
  var _msg = "Escolha uma opção para começar a jogar";
  var _msgStyle = TextStyle(fontSize: 16, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    var _imageSize = 80.0;

    _jogar(opcao) {
      var jogo = Jogo();
      var appOpcao = jogo.GetAppOpcao();
      var ehVencedor = jogo.EhVencedor(opcao, appOpcao);
      setState(() {
        _imagemApp = AssetImage("images/$appOpcao.png");
        var color = Colors.black;
        if(ehVencedor == null){
          _msg = "Empatamos!";
        }else if(ehVencedor){
          _msg = "Você ganhou!";
          color = Colors.green;
        }else{
          _msg = "Você perdeu :(";
          color = Colors.red;
        }
        _msgStyle = TextStyle(fontSize: 25, color: color);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Escolha do App"),
            Image(image: _imagemApp),
            Text(
              _msg,
              style: _msgStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _jogar("pedra"),
                  child: Image.asset("images/pedra.png", width: _imageSize),
                ),
                GestureDetector(
                  onTap: () => _jogar("papel"),
                  child: Image.asset("images/papel.png", width: _imageSize),
                ),
                GestureDetector(
                  onTap: () => _jogar("tesoura"),
                  child: Image.asset("images/tesoura.png", width: _imageSize),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

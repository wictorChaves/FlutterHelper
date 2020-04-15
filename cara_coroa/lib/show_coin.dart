import 'package:flutter/material.dart';

class ShowCoin extends StatefulWidget {

  int randomValue;

  ShowCoin(int randomValue){
    this.randomValue = randomValue;
  }

  @override
  _ShowCoinState createState() => _ShowCoinState(randomValue);

}

class _ShowCoinState extends State<ShowCoin> {

  String _currentCoin = "";

  _ShowCoinState(int randomValue){
    _currentCoin = (randomValue == 0) ? "images/moeda_cara.png" : "images/moeda_coroa.png";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff61bd8c),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(_currentCoin),
          Padding(padding: EdgeInsets.all(15)),
          GestureDetector(
            child: Image.asset("images/botao_voltar.png"),
            onTap: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

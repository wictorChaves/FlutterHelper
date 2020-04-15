import 'dart:math';

import 'package:caracoroa/show_coin.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff61bd8c),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/logo.png"),
          Padding(padding: EdgeInsets.all(15)),
          GestureDetector(
            child: Image.asset("images/botao_jogar.png"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ShowCoin((Random().nextInt(2) == 0) ? "images/moeda_cara.png" : "images/moeda_coroa.png")
              ));
            },
          )
        ],
      ),
    );
  }
}

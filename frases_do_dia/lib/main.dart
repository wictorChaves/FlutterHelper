import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Frases do dia",
    home: Container(
      color: Colors.white,
      child: Column(
        children: [
          Text(
              "Este é um exemplo de um texto mais longo!",
              style: TextStyle(
                fontSize: 35,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                letterSpacing: 10,
                wordSpacing: 20,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.greenAccent,
                color: Colors.black,
                decorationStyle: TextDecorationStyle.solid
              ),
          ),
        ],
      ),
    ),
  ));
}
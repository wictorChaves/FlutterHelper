import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Frases do dia",
    home: Row(children:[
      Text(
          "Texto",
          style: TextStyle(
            fontSize: 25
          ),
      )
    ],),
  ));
}
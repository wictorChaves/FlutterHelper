import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Frases do dia",
    home: Container(
      //color: Colors.white,
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Colors.red
        )
      ),
      child: Column(
        children: [
          Text("Texto"),
        ],
      ),
    ),
  ));
}
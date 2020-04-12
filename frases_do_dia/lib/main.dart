import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Frases do dia",
    home: Container(
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Colors.white
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("T1"),
          Text("T2"),
          Text("T3"),
        ]
      ),
    ),
  ));
}
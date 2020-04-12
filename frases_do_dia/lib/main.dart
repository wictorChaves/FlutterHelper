import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Frases do dia",
    home: Container(
      //color: Colors.white,
      padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
      margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Colors.red
        )
      ),
      child: Column(
        children: [
          Text("T1"),
          Padding(
            child: Text("T2"),
            padding: EdgeInsets.all(20),
          ),
          Text("T3"),
        ],
      ),
    ),
  ));
}
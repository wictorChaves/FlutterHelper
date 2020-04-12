import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Frases do dia",
    home: Container(
      color: Colors.white,
      child: Column(
        children: [
          Text("Texto"),
        ],
      ),
    ),
  ));
}
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Frases do dia",
    home: Container(
      //color: Colors.white,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Colors.red
        )
      ),
      child: Column(
        children: [
          Text(
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
              textAlign: TextAlign.justify,
          ),
        ],
      ),
    ),
  ));
}
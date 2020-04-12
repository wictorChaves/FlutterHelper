import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Frases do dia",
    home: Container(
      color: Colors.white,
      child: Column(
        children: [
          FlatButton(
            onPressed: null,
            child: Text(
              "Botão",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none
              ),
            ),
          ),
        ],
      ),
    ),
  ));
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _HomeState(){
    Firestore.instance
        .collection("usuarios")
        .document("pontuacao")
        .setData({"carlos": "80", "silvana": "374"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Firebase Flutter")), body: Container());
  }
}

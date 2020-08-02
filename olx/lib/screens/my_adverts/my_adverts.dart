import 'package:flutter/material.dart';

class MyAdverts extends StatefulWidget {
  @override
  _MyAdvertsState createState() => _MyAdvertsState();
}

class _MyAdvertsState extends State<MyAdverts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Meus Anúncios")),
        floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.white,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, "/novo-anuncio");
            }),
        body: Container());
  }
}

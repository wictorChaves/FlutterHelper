import 'dart:io';

import 'package:flutter/material.dart';

class OnMyWayUber extends StatefulWidget {
  @override
  _OnMyWayUberState createState() => _OnMyWayUberState();
}

class _OnMyWayUberState extends State<OnMyWayUber> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Padding(
              padding: Platform.isIOS
                  ? EdgeInsets.fromLTRB(20, 10, 20, 25)
                  : EdgeInsets.all(10),
              child: RaisedButton(
                  child: Text(
                    "Motorista a caminho",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.grey,
                  onPressed: (){},
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16))))
    ]);
  }
}

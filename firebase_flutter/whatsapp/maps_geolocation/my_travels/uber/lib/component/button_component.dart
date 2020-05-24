import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber/configs/main_config.dart';

class ButtonComponent {
  static Widget Login({String text, VoidCallback onPressed}) {
    return RaisedButton(
        color: PRIMARY_COLOR,
        padding: EdgeInsets.all(18),
        child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
        onPressed: onPressed);
  }
}

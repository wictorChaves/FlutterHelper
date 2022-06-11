import 'package:flutter/material.dart';

class Helper {
  static void dialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text(title),
          content: new Text(content),
        ));
  }
}
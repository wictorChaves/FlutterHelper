import 'package:flutter/material.dart';

class DialogHelper {

  static Future simple(BuildContext context, String title, String content) {
    return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text(title),
          content: new Text(content),
        ));
  }

  static Future yesNo(BuildContext context, String title, String content, Function callback) {
    return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: [
            FlatButton(
              child: Text('Sim'),
              onPressed: (){
                Navigator.pop(context);
                callback();
              },
            ),
            FlatButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }

}

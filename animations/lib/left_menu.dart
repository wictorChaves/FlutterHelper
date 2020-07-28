import 'package:flutter/material.dart';

class LeftMenu extends StatefulWidget {
  Function(String) callback;

  LeftMenu(this.callback);

  @override
  _LeftMenuState createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
          child: Text('Animações (>‿◠)✌',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          decoration: BoxDecoration(color: Colors.blue)),
      _listTitle('Animação Implicita', 'implicit'),
      _listTitle('Animação Explicita', 'explicit'),
      _listTitle('Animação Básicas 1', 'basic1'),
      _listTitle('Animação Básicas 2', 'basic2'),
      _listTitle('Animação Básicas 3', 'basic3'),
      _listTitle('Animação com Interpolação 1', 'tween1'),
      _listTitle('Animação com Interpolação 2', 'tween2'),
      _listTitle('Animação com Interpolação 3', 'tween3'),
      _listTitle('Animação com Transform 1', 'transform1'),
      _listTitle('Animação com Transform 2', 'transform2'),
      _listTitle('Animação com Transform 3', 'transform3'),
    ]));
  }

  _listTitle(String title, String route) {
    return ListTile(
        title: Text(title),
        onTap: () {
          widget.callback(route);
          Navigator.pop(context);
        });
  }
}

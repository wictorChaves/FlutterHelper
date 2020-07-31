import 'package:flutter/material.dart';
import 'package:olx/configs/main_config.dart';
import 'package:olx/screens/shared/default_popup_menu.dart';

class Adverts extends StatefulWidget {
  @override
  _AdvertsState createState() => _AdvertsState();
}

class _AdvertsState extends State<Adverts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(APP_TITLE),
          elevation: 0,
          actions: <Widget>[DefaultPopupMenu()],
        ),
        body: Container(child: Text("Anúncios")));
  }
}

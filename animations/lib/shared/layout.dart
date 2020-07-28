import 'package:animations/configs/main_configs.dart';
import 'package:flutter/material.dart';

import '../left_menu.dart';
import '../route_content.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  String current_route = "home";

  callback(route) {
    setState(() {
      current_route = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(APP_TITLE)),
        body: RouteContent(current_route),
        drawer: LeftMenu(callback));
  }
}

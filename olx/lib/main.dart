import 'package:flutter/material.dart';
import 'package:olx/configs/main_config.dart';
import 'package:olx/router_config.dart';
import 'package:olx/screens/adverts/adverts.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: theme,
      home: Adverts(),
      initialRoute: "/",
      onGenerateRoute: RouterConfig.generateRoute));
}

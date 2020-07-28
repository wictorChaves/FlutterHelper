import 'package:flutter/material.dart';
import 'package:uber/router_config.dart';

import 'configs/main_config.dart';

final ThemeData themeData =
    ThemeData(primaryColor: Color(0xff37474f), accentColor: Color(0xff546e7a));

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: themeData,
      initialRoute: "/",
      onGenerateRoute: RouterConfig.generateRoute));
}

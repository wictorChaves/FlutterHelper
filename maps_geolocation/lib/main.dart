import 'package:flutter/material.dart';
import 'package:mapsgeolocation/home.dart';

import 'configs/main_configs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: ThemeData(primarySwatch: PRIMARY_COLOR),
      home: Home(),
    );
  }
}

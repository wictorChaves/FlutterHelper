import 'package:flutter/material.dart';
import 'package:uber/screens/home/home.dart';

import 'configs/main_config.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: ThemeData(
          primarySwatch: PRIMARY_COLOR,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Home()));
}

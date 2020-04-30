import 'package:flutter/material.dart';

import 'configs/app_config.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home()));
}

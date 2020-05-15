import 'package:flutter/material.dart';
import 'package:mytravels/splash_screen.dart';

import 'configs/main_configs.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: ThemeData(
          primarySwatch: PRYMARY_COLOR,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: SplashScreen()));
}

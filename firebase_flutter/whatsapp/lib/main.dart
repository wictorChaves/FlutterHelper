import 'package:flutter/material.dart';

import 'configs/app_config.dart';
import 'home.dart';
import 'login.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Color(0xff075E54), accentColor: Color(0xff25D366)),
    title: APP_TITLE,
    home: Login()));

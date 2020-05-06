import 'package:flutter/material.dart';
import 'package:whatsapp/screens/register/register.dart';

import 'configs/app_config.dart';
import 'generate_route.dart';
import 'screens/home/home.dart';
import 'screens/login/login.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: PRIMARY_COLOR, accentColor: ACCENT_COLOR),
    title: APP_TITLE,
    initialRoute: "/",
    onGenerateRoute: GenerateRoute.routes,
    home: Login()));



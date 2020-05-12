import 'dart:io';

import 'package:flutter/material.dart';

import 'configs/app_config.dart';
import 'generate_route.dart';
import 'global/main_theme.dart';
import 'screens/login/login.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: MainTheme.primaryColor,
        accentColor: MainTheme.accentColor),
    title: APP_TITLE,
    initialRoute: "/",
    onGenerateRoute: GenerateRoute.routes,
    home: Login()));

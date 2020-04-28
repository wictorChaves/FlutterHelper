import 'package:flutter/material.dart';

import 'configs.dart';
import 'configs/theme.dart';
import 'home.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: APP_TITLE,
    home: Home(),
    theme: THEME));

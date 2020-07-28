import 'package:animations/shared/layout.dart';
import 'package:flutter/material.dart';

import 'configs/main_configs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: APP_TITLE, home: Layout(), debugShowCheckedModeBanner: false);
  }
}

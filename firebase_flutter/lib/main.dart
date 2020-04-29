import 'package:flutter/material.dart';

import 'home.dart';

void main() {


  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Firebase Flutter',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: Home(),
  ));
}

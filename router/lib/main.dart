import 'package:flutter/material.dart';
import 'package:router/contact.dart';
import 'package:router/services.dart';

import 'home.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/home": (context) => Home(),
      "/contact": (context) => Contact(),
      "/services": (context) => Services(),
    },
    title: "Rotas",
    home: Home(),
  ));
}

import 'package:flutter/material.dart';
import 'package:quotation/splash.dart';
import 'package:quotation/view/settings/internal-configs.dart';
import 'view/home/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Quotation",
    color: InternalConfigs.PRIMARYCOLOR,
    home: Splash(),
  ));
}

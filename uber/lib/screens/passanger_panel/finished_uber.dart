import 'package:flutter/material.dart';
import 'package:uber/screens/passanger_panel/call_uber.dart';

class FinishedUber extends StatefulWidget {
  @override
  _FinishedUberState createState() => _FinishedUberState();
}

class _FinishedUberState extends State<FinishedUber> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [CallUber()]);
  }
}

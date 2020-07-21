import 'package:flutter/material.dart';

import 'call_uber.dart';

class CancelUber extends StatefulWidget {
  @override
  _CancelUberState createState() => _CancelUberState();
}

class _CancelUberState extends State<CancelUber> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [CallUber()]);
  }
}

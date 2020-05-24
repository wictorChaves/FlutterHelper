import 'package:flutter/material.dart';

class WidgetHelper {
  static Widget loading(MaterialColor color) {
    return Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(color)));
  }
}
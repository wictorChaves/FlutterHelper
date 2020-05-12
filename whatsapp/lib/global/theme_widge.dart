import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_theme.dart';

class ThemeWidget {
  static Widget sendButton(String text, VoidCallback onPressed) {
    return MainTheme.isIOS()
        ? CupertinoButton(child: Text(text), onPressed: onPressed)
        : FloatingActionButton(
            backgroundColor: MainTheme.primaryColor,
            child: Icon(Icons.send, color: Colors.white),
            mini: true,
            onPressed: onPressed);
  }
}

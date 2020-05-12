import 'dart:io';

import 'package:flutter/material.dart';

class MainTheme {
  static Color _primaryColor = Color(0xff075E54);
  static Color _accentColor = Color(0xff25D366);
  static Color _errorColor = Color(0xffff0000);

  static Color _messageSentColor = Color(0xffd2ffa5);
  static Color _messageReceived = Colors.white;

  static Color _indicatorColor = isIOS() ? Colors.grey[400] : Colors.white;

  static double _elevation = 4;

  static Color get primaryColor => isIOS() ? Colors.grey[200] : _primaryColor;
  static Color get accentColor => _accentColor;
  static Color get errorColor => _errorColor;
  static Color get messageSentColor => _messageSentColor;
  static Color get messageReceived => _messageReceived;
  static double get elevation => isIOS() ? 0 : _elevation;
  static Color get indicatorColor => _indicatorColor;

  static bool isIOS() => Platform.isIOS;
}

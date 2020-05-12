import 'package:flutter/material.dart';
import 'package:whatsapp/screens/chat/chat.dart';
import 'package:whatsapp/screens/configs/configs.dart';
import 'package:whatsapp/screens/home/home.dart';
import 'package:whatsapp/screens/login/login.dart';
import 'package:whatsapp/screens/register/register.dart';

class GenerateRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Login());
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());
      case "/register":
        return MaterialPageRoute(builder: (_) => Register());
      case "/home":
        return MaterialPageRoute(builder: (_) => Home());
      case "/configs":
        return MaterialPageRoute(builder: (_) => Configs());
      case "/chat":
        return MaterialPageRoute(builder: (_) => Chat(settings.arguments));
      default:
        _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text("Fela não encontrada!")),
          body: Center(child: Text("Fela não encontrada!")));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:olx/screens/adverts/adverts.dart';
import 'package:olx/screens/login/login.dart';
import 'package:olx/screens/register/register.dart';

class RouterConfig {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Login());
      case "/cadastro":
        return MaterialPageRoute(builder: (_) => Register());
      case "/anuncios":
        return MaterialPageRoute(builder: (_) => Adverts());
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());
      default:
        _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text("Tela não encontrada!")),
          body: Center(child: Text("Tela não encontrada!")));
    });
  }
}

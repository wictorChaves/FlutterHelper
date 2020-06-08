import 'package:flutter/material.dart';
import 'package:uber/screens/driver_panel/driver_panel.dart';
import 'package:uber/screens/login/login.dart';
import 'package:uber/screens/passanger_panel/passanger_panel.dart';
import 'package:uber/screens/register/register.dart';

class RouterConfig {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Login());
      case "/cadastro":
        return MaterialPageRoute(builder: (_) => Register());
      case "/painel-motorista":
        return MaterialPageRoute(builder: (_) => DriverPanel());
      case "/painel-passageiro":
        return MaterialPageRoute(builder: (_) => PassangerPanel());
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

import 'package:flutter/material.dart';
import 'package:olx/screens/adverts/adverts.dart';
import 'package:olx/screens/login/login.dart';
import 'package:olx/screens/my_adverts/my_adverts.dart';
import 'package:olx/screens/new_advert/new_advert.dart';
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
      case "/meus-anuncios":
        return MaterialPageRoute(builder: (_) => MyAdverts());
      case "/novo-anuncio":
        return MaterialPageRoute(builder: (_) => NewAdvert());
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

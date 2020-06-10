import 'package:flutter/material.dart';
import 'package:uber/core/services/auth_service.dart';

class DriverPanel extends StatefulWidget {
  @override
  _DriverPanelState createState() => _DriverPanelState();
}

class _DriverPanelState extends State<DriverPanel> {
  AuthService _authService = AuthService();

  var _itemsMenu = ["Configurações", "Deslogar"];

  _onSelectMenuItem(String selectedItem) {
    switch (selectedItem) {
      case "Configurações":
        _config();
        break;
      case "Deslogar":
        _logout();
        break;
    }
  }

  _config() {}

  _logout() {
    _authService.Logout();
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Motorista"), actions: [
          PopupMenuButton(
              onSelected: _onSelectMenuItem,
              itemBuilder: (context) {
                return _itemsMenu.map((String item) {
                  return PopupMenuItem(value: item, child: Text(item));
                }).toList();
              })
        ]),
        body: Container(
            child: RaisedButton(
                onPressed: () {
                  _authService.Logout();
                },
                child: Text("sair"))));
  }
}

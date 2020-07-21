import 'package:flutter/material.dart';
import 'package:uber/core/services/auth_service.dart';

class DefaultPopupMenu extends StatefulWidget {
  @override
  _DefaultPopupMenuState createState() => _DefaultPopupMenuState();
}

class _DefaultPopupMenuState extends State<DefaultPopupMenu> {
  AuthService _authService = AuthService();

  var _itemsMenu = ["Configurações", "Deslogar"];

  _config() {}

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

  _logout() {
    _authService.Logout();
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: _onSelectMenuItem,
        itemBuilder: (context) {
          return _itemsMenu.map((String item) {
            return PopupMenuItem(value: item, child: Text(item));
          }).toList();
        });
  }
}

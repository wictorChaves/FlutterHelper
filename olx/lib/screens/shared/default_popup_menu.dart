import 'package:flutter/material.dart';
import 'package:olx/core/services/auth_service.dart';

class DefaultPopupMenu extends StatefulWidget {
  @override
  _DefaultPopupMenuState createState() => _DefaultPopupMenuState();
}

class _DefaultPopupMenuState extends State<DefaultPopupMenu> {
  AuthService _authService = AuthService();

  List<String> _itemsMenu = [];

  _config() {}

  _onSelectMenuItem(String selectedItem) {
    switch (selectedItem) {
      case "Meus anúncios":
        _config();
        break;
      case "Deslogar":
        _logout();
        break;
      case "Entrar / Cadastrar":
        _login();
        break;
    }
  }

  _logout() {
    _authService.Logout();
    Navigator.pushReplacementNamed(context, "/");
  }

  _login() {
    Navigator.pushReplacementNamed(context, "/login");
  }

  _renderMenu() async {
    bool isLogged = await _authService.IsLogged();
    if (isLogged) {
      setItemsMenu(["Meus anúncios", "Deslogar"]);
    } else {
      setItemsMenu(["Entrar / Cadastrar"]);
    }
  }

  setItemsMenu(itemsMenu) {
    setState(() {
      _itemsMenu = itemsMenu;
    });
  }

  @override
  void initState() {
    super.initState();
    _renderMenu();
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

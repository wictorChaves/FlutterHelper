import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/helper/dialog_helper.dart';
import 'package:whatsapp/screens/home/tabs/tab_base.dart';
import 'package:whatsapp/screens/login/login.dart';
import 'package:whatsapp/services/auth_service.dart';

import 'tabs/contact/contact.dart';
import 'tabs/conversation/conversation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService;

  _HomeState() {
    _authService = AuthService();
  }

  _logout(context) {
    _authService.Logout().then((_) {
      Navigator.pushReplacementNamed(context, "/login");
    }).catchError((erro) =>
        DialogHelper.simple(context, "Erro!", "Erro ao tentar sair!"));
  }

  List<TabBase> _tabs = [Conversation(), Contact()];
  List<Choice> _popupMenuItems = [
    Choice("config", "Configurações"),
    Choice("logout", "Deslogar")
  ];

  void _popupMenuSelect(String choice) {
    switch (choice) {
      case "config":
        Navigator.pushNamed(context, "/configs");
        break;
      case "logout":
        _authService.Logout().then((_) {
          Navigator.pushReplacementNamed(context, "/login");
        }).catchError((error) {});
        break;
      default:
        print(choice);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
            appBar: AppBar(
                title: Text("Whatsapp"),
                bottom: TabBar(
                    indicatorWeight: 4,
                    labelStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    indicatorColor: Colors.white,
                    tabs: _tabs.map((item) => Tab(text: item.Title)).toList()),
                actions: [
                  PopupMenuButton<String>(
                      onSelected: _popupMenuSelect,
                      itemBuilder: (BuildContext context) {
                        return _popupMenuItems.map((Choice choice) {
                          return PopupMenuItem<String>(
                            value: choice.id,
                            child: Text(choice.title),
                          );
                        }).toList();
                      })
                ]),
            body: TabBarView(children: _tabs)));
  }
}

class Choice {
  const Choice(this.id, this.title);

  final String id;
  final String title;
}

import 'package:flutter/material.dart';
import 'package:uber/core/services/auth_service.dart';

class PassangerPanel extends StatefulWidget {
  @override
  _PassangerPanelState createState() => _PassangerPanelState();
}

class _PassangerPanelState extends State<PassangerPanel> {

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Passageiro")),
        body: Container(child: RaisedButton(
          onPressed: (){
            _authService.Logout();
          },
          child: Text("sair")
        ))
    );
  }
}

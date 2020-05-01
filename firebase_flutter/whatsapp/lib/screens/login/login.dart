import 'package:flutter/material.dart';
import 'package:whatsapp/screens/register/register.dart';
import 'package:whatsapp/theme/component_helper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _noAccount() => Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) => Register()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: Color(0xff075E54)),
            padding: EdgeInsets.all(16),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 32),
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 200,
                        height: 150,
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: ComponentHelper.InputFieldCircular(
                          "E-mail", TextInputType.emailAddress,
                          autofocus: true)),
                  ComponentHelper.InputFieldCircular(
                      "Senha", TextInputType.text),
                  Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 10),
                      child: ComponentHelper.RaisedButtonCircular("Entrar")),
                  Center(
                      child: GestureDetector(
                          child: Text("Não tem conta? cadastre-se!",
                              style: TextStyle(color: Colors.white)),
                          onTap: _noAccount))
                ])))));
  }
}

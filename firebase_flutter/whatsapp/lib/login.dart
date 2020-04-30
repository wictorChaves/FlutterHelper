import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget _inputField(String hintText, TextInputType textInputType,
      {bool autofocus = false}) {
    return TextField(
      autofocus: autofocus,
      keyboardType: textInputType,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
    );
  }

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
                  child: _inputField("E-mail", TextInputType.emailAddress,
                      autofocus: true)),
              _inputField("Senha", TextInputType.text),
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 10),
                child: RaisedButton(
                    child: Text("Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onPressed: () {}),
              ),
              Center(
                  child: GestureDetector(
                      child: Text(
                        "Não tem conta? cadastre-se!",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {}))
            ]))),
      ),
    );
  }
}

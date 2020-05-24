import 'package:flutter/material.dart';
import 'package:uber/component/button_component.dart';
import 'package:uber/component/dialog_helper.dart';
import 'package:uber/component/input_component.dart';
import 'package:uber/screens/home/validate/home_validate.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  HomeValidate _homeValidate;

  _HomeState() {
    _homeValidate = HomeValidate();
  }

  _btnSubmit() {
    print("form:" + _formKey.currentState.validate().toString());
    if (_formKey.currentState.validate()) {
      DialogHelper.simple(context, "title", "content");
    }
  }

  _register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/fundo.png"),
                    fit: BoxFit.cover)),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Image.asset("assets/images/logo.png",
                              width: 150, height: 150)),
                      InputComponent.Login(
                          hintText: 'E-mail', validator: _homeValidate.Email),
                      InputComponent.Login(
                          hintText: 'Senha',
                          obscureText: true,
                          validator: _homeValidate.Password),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: ButtonComponent.Login(
                            text: "Entrar", onPressed: _btnSubmit)
                      ),
                      GestureDetector(
                          child: Center(
                              child: Text("Não tem conta? Cadastra-se!",
                                  style: TextStyle(color: Colors.white))),
                          onTap: _register)
                    ]))));
  }
}

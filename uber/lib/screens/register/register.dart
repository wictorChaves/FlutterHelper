import 'package:flutter/material.dart';
import 'package:uber/component/button_component.dart';
import 'package:uber/component/dialog_helper.dart';
import 'package:uber/component/input_component.dart';
import 'package:uber/screens/register/validate/register_validate.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  RegisterValidate _registerValidate;
  bool _driver = false;

  _RegisterState() {
    _registerValidate = RegisterValidate();
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
        appBar:
            AppBar(title: Text("Cadastro"), backgroundColor: Colors.black54),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: InputComponent.Login(
                              hintText: 'Nome Completo',
                              validator: _registerValidate.Text)),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: InputComponent.Login(
                              hintText: 'E-mail',
                              validator: _registerValidate.Email)),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: InputComponent.Login(
                              hintText: 'Senha',
                              obscureText: true,
                              validator: _registerValidate.Password)),
                      SwitchListTile(
                        value: _driver,
                        title: Text("Motorista"),
                        subtitle: Text("Marque se deseja ser um motorista."),
                        onChanged: (value) {
                          setState(() {
                            _driver = value;
                          });
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: ButtonComponent.Login(
                              text: "Entrar", onPressed: _btnSubmit)),
                      GestureDetector(
                          child: Center(
                              child: Text("Não tem conta? Cadastra-se!",
                                  style: TextStyle(color: Colors.white))),
                          onTap: _register)
                    ]))));
  }
}

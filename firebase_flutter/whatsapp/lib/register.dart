import 'package:flutter/material.dart';
import 'package:whatsapp/theme/component_helper.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _msgError = "";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _validate() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (name.length < 3) return "O campo nome deve ter no mínimo 3 digitos";
    var regexEmail =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    if (!RegExp(regexEmail).hasMatch(email)) return "E-mail inválido";
    if (password.length < 6)
      return "O campo senha deve ter no mínimo 6 digitos";
    return "";
  }

  _btnRegister() {
    setState(() {
      _msgError = _validate();
    });
    if (_msgError.length > 0) return;
    _register();
  }

  void _register() {
    _msgError = "FOI!!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Cadastro")),
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
                        "assets/images/usuario.png",
                        width: 200,
                        height: 150,
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: ComponentHelper.InputFieldCircular(
                          "Nome", TextInputType.text,
                          autofocus: true, controller: _nameController)),
                  Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: ComponentHelper.InputFieldCircular(
                          "E-mail", TextInputType.emailAddress,
                          controller: _emailController)),
                  Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: ComponentHelper.InputFieldCircular(
                          "Senha", TextInputType.text,
                          obscure: true, controller: _passwordController)),
                  Center(
                      child: GestureDetector(
                          child: Text(_msgError,
                              style: TextStyle(
                                  color: Color(0xffff0000), fontSize: 20)))),
                  Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 10),
                      child: ComponentHelper.RaisedButtonCircular("Cadastrar",
                          onPressed: _btnRegister))
                ])))));
  }
}

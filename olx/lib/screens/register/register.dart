import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx/core/services/auth_service.dart';
import 'package:olx/screens/register/validate/register_validate.dart';
import 'package:olx/screens/shared/input_custom.dart';
import 'package:olx/services/model/user_model.dart';
import 'package:olx/services/user_service.dart';
import 'package:olx/store/store.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  AuthService _authService = AuthService();
  RegisterValidate _registerValidate = RegisterValidate();
  UserService _userService = UserService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _register() {
    if (_formKey.currentState.validate()) {
      _authService.Create(_emailController.text, _passwordController.text)
          .then((AuthResult authResult) {
        UserModel userModel = UserModel(
            authResult.user.uid, _nameController.text, _emailController.text);
        _userService.CreateOrUpdate(userModel).then((_) {
          Store.userModel = userModel;
          Navigator.pushReplacementNamed(context, "/anuncios");
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _nameController.text = "Nome de teste";
    _emailController.text = "teste@teste.com";
    _passwordController.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Center(
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 32),
                          child: Image.asset("assets/images/logo.png",
                              width: 200, height: 150)),
                      InputCustom(
                        controller: _nameController,
                        hintText: "Nome",
                        validator: _registerValidate.Text,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                      ),
                      InputCustom(
                        controller: _emailController,
                        hintText: "E-mail",
                        validator: _registerValidate.Email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      InputCustom(
                          controller: _passwordController,
                          hintText: "Senha",
                          validator: _registerValidate.Password,
                          keyboardType: TextInputType.text,
                          obscureText: true),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: RaisedButton(
                              child: Text("Cadastrar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              color: Color(0xff9c27b0),
                              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                              onPressed: _register))
                    ]))))));
  }
}

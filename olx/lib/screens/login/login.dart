import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx/core/services/auth_service.dart';
import 'package:olx/screens/login/validate/login_validate.dart';
import 'package:olx/screens/shared/input_custom.dart';
import 'package:olx/services/model/user_model.dart';
import 'package:olx/services/user_service.dart';
import 'package:olx/store/store.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  AuthService _authService = AuthService();
  LoginValidate _loginValidate = LoginValidate();
  UserService _userService = UserService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _LoginState() {
    _emailController.text = "teste@teste.com";
    _passwordController.text = "123456";
  }

  _btnSubmit() {
    if (_formKey.currentState.validate()) {
      _authService.Login(_emailController.text, _passwordController.text)
          .then((AuthResult authResult) {
        _redirectByUser(authResult.user);
      });
    }
  }

  _register() {
    Navigator.pushNamed(context, "/cadastro");
  }

  @override
  void initState() {
    super.initState();
    _checkLogged();
  }

  Future<void> _checkLogged() async {
    var currentUser = await _authService.GetCurrentUser();
    if (currentUser != null) {
      _redirectByUser(currentUser);
    }
  }

  _redirectByUser(FirebaseUser user) {
    _userService.GetById(user.uid).then((UserModel userModel) {
      Store.userModel = userModel;
      Navigator.pushReplacementNamed(context, "/anuncios");
    });
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
                        controller: _emailController,
                        hintText: "E-mail",
                        validator: _loginValidate.Email,
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      InputCustom(
                          controller: _passwordController,
                          hintText: "Senha",
                          validator: _loginValidate.Password),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: RaisedButton(
                              child: Text("Entrar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              color: Color(0xff9c27b0),
                              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                              onPressed: _btnSubmit)),
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: GestureDetector(
                              child: Center(
                                  child: Text("Não tem conta? Cadastra-se!",
                                      style: TextStyle(color: Colors.black))),
                              onTap: _register))
                    ]))))));
  }
}

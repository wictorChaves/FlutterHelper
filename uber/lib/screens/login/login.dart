import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/component/button_component.dart';
import 'package:uber/component/dialog_helper.dart';
import 'package:uber/component/input_component.dart';
import 'package:uber/core/services/auth_service.dart';
import 'package:uber/screens/login/validate/login_validate.dart';
import 'package:uber/services/model/user_model.dart';
import 'package:uber/services/user_service.dart';

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
      Navigator.pushReplacementNamed(context,
          userModel.isDriver ? "/painel-motorista" : "/painel-passageiro");
    });
  }

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
                          controller: _emailController,
                          hintText: 'E-mail',
                          validator: _loginValidate.Email),
                      InputComponent.Login(
                          controller: _passwordController,
                          hintText: 'Senha',
                          obscureText: true,
                          validator: _loginValidate.Password),
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

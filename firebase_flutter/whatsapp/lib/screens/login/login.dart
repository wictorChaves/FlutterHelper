import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/global/main_global.dart';
import 'package:whatsapp/helper/dialog_helper.dart';
import 'package:whatsapp/screens/login/viewmodel/user_view_model.dart';
import 'package:whatsapp/screens/register/validate/register_validate.dart';
import 'package:whatsapp/services/auth_service.dart';
import 'package:whatsapp/services/model/user_model.dart';
import 'package:whatsapp/services/user_service.dart';
import 'package:whatsapp/theme/component_helper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  RegisterValidate _validation;
  AuthService _authService;
  UserService _userService;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _LoginState() {
    _validation = RegisterValidate();
    _authService = AuthService();
    _userService = UserService();
  }

  _btnLogin() {
    return (_formKey.currentState.validate())
        ? _login(UserViewModel(
            _emailController.text,
            _passwordController.text,
          ))
        : null;
  }

  _login(UserViewModel viewModel) {
    _authService.Login(viewModel.email, viewModel.password)
        .then((AuthResult authResult) => _saveUser(authResult.user))
        .catchError((erro) => DialogHelper.simple(context, "Erro!",
            "Erro ao tentar entrar, verifica seu e-mail e a sua senha!"));
  }

  _noAccount() => Navigator.pushNamed(context, "/register");

  @override
  void initState() {
    super.initState();
    _authService.GetCurrentUser().then(_saveUser);
  }

  _saveUser(FirebaseUser user) async {
    print(user);
    if (user == null) return;
    MainGlobal.userModel = await _userService.GetById(user.uid);
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: Color(0xff075E54)),
            padding: EdgeInsets.all(16),
            child: Center(
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(bottom: 32),
                                  child: Image.asset("assets/images/logo.png",
                                      width: 200, height: 150)),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: ComponentHelper.InputFieldCircular(
                                      "E-mail", TextInputType.emailAddress,
                                      controller: _emailController,
                                      autofocus: true,
                                      validator: _validation.Email)),
                              ComponentHelper.InputFieldCircular(
                                  "Senha", TextInputType.text,
                                  obscure: true,
                                  controller: _passwordController,
                                  validator: _validation.Password),
                              Padding(
                                  padding: EdgeInsets.only(top: 16, bottom: 10),
                                  child: ComponentHelper.RaisedButtonCircular(
                                      "Entrar",
                                      onPressed: _btnLogin)),
                              Center(
                                  child: GestureDetector(
                                      child: Text("Não tem conta? cadastre-se!",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onTap: _noAccount))
                            ]))))));
  }
}

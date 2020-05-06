import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/helper/dialog_helper.dart';
import 'package:whatsapp/screens/home/home.dart';
import 'package:whatsapp/screens/register/validate/register_validate.dart';
import 'package:whatsapp/screens/register/viewmodel/user_view_model.dart';
import 'package:whatsapp/services/auth_service.dart';
import 'package:whatsapp/services/model/user_model.dart';
import 'package:whatsapp/services/user_service.dart';
import 'package:whatsapp/theme/component_helper.dart';
import 'package:whatsapp/configs/app_config.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterValidate _validation;
  AuthService _authService;
  UserService _userService;

  final _formKey = GlobalKey<FormState>();
  Map<String, TextEditingController> controllers = {
    "name": TextEditingController(),
    "email": TextEditingController(),
    "password": TextEditingController()
  };

  _RegisterState() {
    _validation = RegisterValidate();
    _authService = AuthService();
    _userService = UserService();
  }

  _btnRegister() {
    return (_formKey.currentState.validate())
        ? _register(UserViewModel(controllers["name"].text,
            controllers["email"].text, controllers["password"].text))
        : null;
  }

  _register(UserViewModel viewModel) {
    _authService.Create(viewModel.email, viewModel.password)
        .then((AuthResult authResult) => _afterRegister(viewModel))
        .catchError((erro) =>
            DialogHelper.simple(context, "Erro!", "Erro ao tentar cadastrar!"));
  }

  _afterRegister(UserViewModel viewModel) {
    UserModel model =
        UserModel.fromJson({"name": viewModel.name, "email": viewModel.email});
    _userService.CreateOrUpdate(model);
    Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Cadastro")),
        body: Container(
            decoration: BoxDecoration(color: PRIMARY_COLOR),
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
                                  child: Image.asset(
                                    "assets/images/usuario.png",
                                    width: 200,
                                    height: 150,
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: ComponentHelper.InputFieldCircular(
                                      "Nome", TextInputType.text,
                                      autofocus: true,
                                      controller: controllers["name"],
                                      validator: _validation.Text)),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: ComponentHelper.InputFieldCircular(
                                      "E-mail", TextInputType.emailAddress,
                                      controller: controllers["email"],
                                      validator: _validation.Email)),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: ComponentHelper.InputFieldCircular(
                                      "Senha", TextInputType.text,
                                      obscure: true,
                                      controller: controllers["password"],
                                      validator: _validation.Password)),
                              Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 10),
                                  child: ComponentHelper.RaisedButtonCircular(
                                      "Cadastrar",
                                      onPressed: _btnRegister))
                            ]))))));
  }
}

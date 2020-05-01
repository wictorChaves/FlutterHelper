import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/helper/dialog_helper.dart';
import 'package:whatsapp/screens/home/home.dart';
import 'package:whatsapp/screens/register/validate/register_validate.dart';
import 'package:whatsapp/screens/register/viewmodel/user_view_model.dart';
import 'package:whatsapp/services/auth_service.dart';
import 'package:whatsapp/theme/component_helper.dart';
import 'package:whatsapp/configs/app_config.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  RegisterValidate _validation;
  AuthService _authService;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _RegisterState() {
    _validation = RegisterValidate();
    _authService = AuthService();
  }

  _btnRegister() {
    return (_formKey.currentState.validate())
        ? _register(UserViewModel(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
          ))
        : null;
  }

  _register(UserViewModel viewModel) {
    _authService.Create(viewModel.email, viewModel.password)
        .then((AuthResult authResult) => Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext buildContext) => Home())))
        .catchError((erro) =>
            DialogHelper.simple(context, "Erro!", "Erro ao tentar cadastrar!"));
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
                                      controller: _nameController,
                                      validator: _validation.Text)),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: ComponentHelper.InputFieldCircular(
                                      "E-mail", TextInputType.emailAddress,
                                      controller: _emailController,
                                      validator: _validation.Email)),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: ComponentHelper.InputFieldCircular(
                                      "Senha", TextInputType.text,
                                      obscure: true,
                                      controller: _passwordController,
                                      validator: _validation.Password)),
                              Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 10),
                                  child: ComponentHelper.RaisedButtonCircular(
                                      "Cadastrar",
                                      onPressed: _btnRegister))
                            ]))))));
  }
}

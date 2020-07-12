import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/component/button_component.dart';
import 'package:uber/component/dialog_helper.dart';
import 'package:uber/component/input_component.dart';
import 'package:uber/core/services/auth_service.dart';
import 'package:uber/screens/register/validate/register_validate.dart';
import 'package:uber/services/model/user_model.dart';
import 'package:uber/services/user_service.dart';
import 'package:uber/store/store.dart';

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

  bool _isDriver = false;

  _btnSubmit() {
    if (_formKey.currentState.validate()) {
      _authService.Create(_emailController.text, _passwordController.text)
          .then((AuthResult authResult) {
        UserModel userModel = UserModel(authResult.user.uid,
            _nameController.text, _emailController.text, _isDriver);
        _userService.CreateOrUpdate(userModel).then((_) {
          Store.userModel = userModel;
          Navigator.pushReplacementNamed(
              context, _isDriver ? "/painel-motorista" : "/painel-passageiro");
        });
      });
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
                              controller: _nameController,
                              validator: _registerValidate.Text)),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: InputComponent.Login(
                              hintText: 'E-mail',
                              controller: _emailController,
                              validator: _registerValidate.Email)),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: InputComponent.Login(
                              hintText: 'Senha',
                              controller: _passwordController,
                              obscureText: true,
                              validator: _registerValidate.Password)),
                      SwitchListTile(
                        value: _isDriver,
                        title: Text("Motorista"),
                        subtitle: Text("Marque se deseja ser um motorista."),
                        onChanged: (value) {
                          setState(() {
                            _isDriver = value;
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

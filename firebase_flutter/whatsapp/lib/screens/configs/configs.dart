import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/global/main_global.dart';
import 'package:whatsapp/helper/dialog_helper.dart';
import 'package:whatsapp/screens/configs/validate/configs_validate.dart';
import 'package:whatsapp/services/auth_service.dart';
import 'package:whatsapp/services/storage_service.dart';
import 'package:whatsapp/services/user_service.dart';
import 'package:whatsapp/theme/component_helper.dart';

import 'circle_avatar_custom.dart';

class Configs extends StatefulWidget {
  @override
  _ConfigsState createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  final _formKey = GlobalKey<FormState>();
  ConfigsValidate _validation;
  TextEditingController _nameController = TextEditingController();

  StorageService _storageService;
  AuthService _authService;
  UserService _userService;

  CircleAvatarCustom _circleAvatarCustom;
  StorageUploadTask _storageUploadTask = null;

  _ConfigsState() {
    _validation = ConfigsValidate();
    _storageService = StorageService("profile");
    _authService = AuthService();
    _userService = UserService();
  }

  Future<void> _upload(ImageSource source) async {
    File file = await ImagePicker.pickImage(source: source);
    _setImage(file);
  }

  _setImage(File file) {
    setState(() {
      _storageUploadTask =
          _storageService.SetFile(file, MainGlobal.userModel.uid + ".jpg");
    });
    _storageUploadTask.onComplete.then((StorageTaskSnapshot snapshot) async {
      _userService.UpdateProperty(MainGlobal.userModel,
          {"urlImage": await snapshot.ref.getDownloadURL()});
    });
  }

  _btnSave(context) {
    MainGlobal.userModel.name = _nameController.text;
    _userService.CreateOrUpdate(MainGlobal.userModel).then((dynamic uid) {
      DialogHelper.simple(context, "Sucesso!", "Nome alterado com sucesso!");
    }).catchError(() {
      DialogHelper.simple(context, "Erro!", "Erro ao tentar alterar o nome!");
    });
  }

  @override
  void initState() {
    super.initState();
    _authService.GetCurrentUser().then((FirebaseUser user) {
      _nameController.text = MainGlobal.userModel.name;
    });
    _circleAvatarCustom =
        CircleAvatarCustom(MainGlobal.userModel.urlImage ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Configurações")),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _circleAvatarCustom.LoadUploadImage(_storageUploadTask),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FlatButton(
                                onPressed: () => _upload(ImageSource.camera),
                                child: Text("Câmera")),
                            FlatButton(
                                onPressed: () => _upload(ImageSource.gallery),
                                child: Text("Galeria"))
                          ]),
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ComponentHelper.InputFieldCircular(
                              "Nome", TextInputType.text,
                              controller: _nameController,
                              autofocus: true,
                              validator: _validation.Text)),
                      ComponentHelper.RaisedButtonCircular("Salvar",
                          onPressed: () => _btnSave(context))
                    ]))));
  }
}

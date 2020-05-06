import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/helper/widget_helper.dart';
import 'package:whatsapp/screens/configs/validate/configs_validate.dart';
import 'package:whatsapp/services/auth_service.dart';
import 'package:whatsapp/services/firestore_service.dart';
import 'package:whatsapp/services/model/imodel.dart';
import 'package:whatsapp/services/model/user_model.dart';
import 'package:whatsapp/services/storage_service.dart';
import 'package:whatsapp/services/user_service.dart';
import 'package:whatsapp/theme/component_helper.dart';

class Configs extends StatefulWidget {
  @override
  _ConfigsState createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  final _formKey = GlobalKey<FormState>();
  ConfigsValidate _validation;

  StorageService _storageService;
  AuthService _authService;
  UserService _userService;

  TextEditingController _nameController = TextEditingController();
  bool _loadingImage = false;
  String _image = null;

  _ConfigsState() {
    _validation = ConfigsValidate();

    _storageService = StorageService("images");
    _authService = AuthService();
    _userService = UserService();
  }

  Future<void> _upload(ImageSource source) async {
    File file = await ImagePicker.pickImage(source: source);
    setImage(file);
  }

  setImage(File file) {
    setState(() {
      _loadingImage = true;
    });
    StorageUploadTask storageUploadTask =
        _storageService.SetFile(file, "perfil.jpg");
    storageUploadTask.onComplete.then((StorageTaskSnapshot snapshot) async {
      snapshot.ref.getDownloadURL().then((url) {
        setState(() {
          _image = url;
          _loadingImage = false;
        });
      });
    });
  }

  void _btnSave() {
    _userService.GetById("D8yOmiMW5mefvqXeaMJJxprQJa62").then((UserModel userModel) {
      print("----------------------------------------------------------------------");
      print(userModel);
      print("----------------------------------------------------------------------");
      //print("Aqui: " + userModel.name);
      //_nameController.text = userModel.name;
    });
  }

  @override
  void initState() {
    super.initState();
    print("Aqui: Start");
    _authService.GetCurrentUser().then((FirebaseUser user) {
      print("Aqui: " + user.uid);
    });
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
                      _loadingImage
                          ? WidgetHelper.loading(Colors.green)
                          : _image == null
                              ? CircleAvatar(
                                  maxRadius: 100, backgroundColor: Colors.grey)
                              : Image.network(_image, fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) {
                                    return CircleAvatar(
                                        backgroundImage: NetworkImage(_image),
                                        maxRadius: 100,
                                        backgroundColor: Colors.grey);
                                  }
                                  return Center(
                                      child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null));
                                }),
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
                          onPressed: _btnSave)
                    ]))));
  }
}

_teste() {
  return;
}

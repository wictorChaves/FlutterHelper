import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'configs/app_config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {}

  File _image;

  _getCameraImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() => _image = image);
  }

  _getGaleryImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() => _image = image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(APP_TITLE)),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RaisedButton.icon(
                    onPressed: _getCameraImage,
                    icon: Icon(Icons.camera_alt),
                    label: Text("Câmera"),
                  ),
                  RaisedButton.icon(
                    onPressed: _getGaleryImage,
                    icon: Icon(Icons.image),
                    label: Text("Galeria"),
                  ),
                  _image == null ? Container() : Image.file(_image)
                ])));
  }
}

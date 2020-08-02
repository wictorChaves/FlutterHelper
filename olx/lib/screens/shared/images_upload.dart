import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx/screens/new_advert/validate/new_advert_validate.dart';

class ImagesUpload extends StatefulWidget {
  final Function(PickedFile) sendImage;

  ImagesUpload(this.sendImage);

  @override
  _ImagesUploadState createState() => _ImagesUploadState();
}

class _ImagesUploadState extends State<ImagesUpload> {
  List<PickedFile> _imageList = List();
  NewAdvertValidate newAdvertValidate = NewAdvertValidate();

  _selectGaleryImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageList.add(pickedFile);
      });
      widget.sendImage(pickedFile);
    }
  }

  Widget _btnAdd() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
            onTap: () {
              _selectGaleryImage();
            },
            child: CircleAvatar(
                backgroundColor: Colors.grey[400],
                radius: 50,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_a_photo,
                          size: 40, color: Colors.grey[100]),
                      Text("Adicionar",
                          style: TextStyle(color: Colors.grey[100]))
                    ]))));
  }

  GestureTapCallback _btnRemove(indice) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Image.file(File(_imageList[indice].path)),
              FlatButton(
                  child: Text("Excluir"),
                  textColor: Colors.red,
                  onPressed: () {
                    setState(() {
                      _imageList.removeAt(indice);
                      Navigator.of(context).pop();
                    });
                  })
            ])));
  }

  Widget _previewImage(indice) {
    return CircleAvatar(
        radius: 50,
        backgroundImage: FileImage(File(_imageList[indice].path)),
        child: Container(
            color: Color.fromRGBO(255, 255, 255, 0.4),
            alignment: Alignment.center,
            child: Icon(Icons.delete, color: Colors.red)));
  }

  Widget _contentImagePreview(indice) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
            onTap: () => _btnRemove(indice), child: _previewImage(indice)));
  }

  Widget _listView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _imageList.length + 1,
        itemBuilder: (context, indice) {
          return (indice == _imageList.length)
              ? _btnAdd()
              : _contentImagePreview(indice);
        });
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<PickedFile>>(
        initialValue: _imageList,
        validator: newAdvertValidate.Image,
        builder: (state) {
          return Column(children: <Widget>[
            Container(height: 100, child: _listView()),
            if (state.hasError) _stateError(state)
          ]);
        });
  }

  Widget _stateError(state) {
    return Container(
        child: Text("[${state.errorText}]",
            style: TextStyle(color: Colors.red, fontSize: 14)));
  }
}

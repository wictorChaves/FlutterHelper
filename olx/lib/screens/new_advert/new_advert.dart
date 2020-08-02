import 'dart:io';

import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:brasil_fields/formatter/telefone_input_formatter.dart';
import 'package:brasil_fields/modelos/estados.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx/core/services/firebase_storage_service.dart';
import 'package:olx/screens/new_advert/validate/new_advert_validate.dart';
import 'package:olx/screens/shared/button_custom.dart';
import 'package:olx/screens/shared/images_upload.dart';
import 'package:olx/screens/shared/input_custom.dart';
import 'package:olx/services/model/advert_model.dart';

class NewAdvert extends StatefulWidget {
  @override
  _NewAdvertState createState() => _NewAdvertState();
}

class _NewAdvertState extends State<NewAdvert> {
  FirebaseStorageService _firebaseStorageService = FirebaseStorageService();
  NewAdvertValidate newAdvertValidate = NewAdvertValidate();
  List<PickedFile> _imageList = List();
  List<DropdownMenuItem<String>> _stateList = List();
  List<DropdownMenuItem<String>> _categoryList = List();
  final _formKey = GlobalKey<FormState>();

  AdvertModel _advertModel = AdvertModel.empty();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  _dataTest() {
    _titleController.text = "Titulo teste";
    _priceController.text = "10";
    _phoneController.text = "31995332654";
    _descriptionController.text = "Uma pequena descrição";

    _advertModel.state = "MG";
    _advertModel.category = "auto";
  }

  @override
  void initState() {
    super.initState();
    _loadItemsDropdown();
    _dataTest();
  }

  _getImage(PickedFile pickedFile) {
    _imageList.add(pickedFile);
  }

  _register() async {
    if (_formKey.currentState.validate()) {
      _advertModel.title = _titleController.text;
      _advertModel.price = _priceController.text;
      _advertModel.phone = _phoneController.text;
      _advertModel.description = _descriptionController.text;
      await _uploadImages();
    }
  }

  Future _uploadImages() async {
    for (var image in _imageList) {
      String downloadUrl = await _firebaseStorageService.Upload(
          File(image.path),
          path: "meus_anuncios/ID_ANUNCIO");
      _advertModel.addImage("teste");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Novo anúncio"),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ImagesUpload(_getImage),
                          Row(children: <Widget>[
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: DropdownButtonFormField(
                                        value: _advertModel.state,
                                        hint: Text("Estados"),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                        items: _stateList,
                                        validator: newAdvertValidate.Dropdown,
                                        onChanged: (value) {
                                          setState(() {
                                            _advertModel.state = value;
                                          });
                                        }))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: DropdownButtonFormField(
                                        value: _advertModel.category,
                                        hint: Text("Categorias"),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                        items: _categoryList,
                                        validator: newAdvertValidate.Dropdown,
                                        onChanged: (value) {
                                          setState(() {
                                            _advertModel.category = value;
                                          });
                                        })))
                          ]),
                          Padding(
                              padding: EdgeInsets.only(bottom: 15, top: 15),
                              child: InputCustom(
                                  controller: _titleController,
                                  hintText: "Título",
                                  validator: newAdvertValidate.Text)),
                          Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: InputCustom(
                                  controller: _priceController,
                                  hintText: "Preço",
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    RealInputFormatter(centavos: true)
                                  ],
                                  validator: newAdvertValidate.Text)),
                          Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: InputCustom(
                                  controller: _phoneController,
                                  hintText: "Telefone",
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    TelefoneInputFormatter()
                                  ],
                                  validator: newAdvertValidate.Text)),
                          Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: InputCustom(
                                  controller: _descriptionController,
                                  hintText: "Descrição (200 caracteres)",
                                  maxLines: null,
                                  validator: newAdvertValidate.TextMuitiLine)),
                          ButtonCustom(
                              text: "Cadastrar anúncio", onPressed: _register)
                        ])))));
  }

  _loadItemsDropdown() {
    _loadCategory();
    _loadStates();
  }

  _loadStates() {
    for (var estado in Estados.listaEstadosAbrv) {
      _stateList.add(DropdownMenuItem(child: Text(estado), value: estado));
    }
  }

  _loadCategory() async {
    _categoryList
        .add(DropdownMenuItem(child: Text("Automóvel"), value: "auto"));
    _categoryList.add(DropdownMenuItem(child: Text("Imóvel"), value: "imovel"));
    _categoryList
        .add(DropdownMenuItem(child: Text("Eletrônicos"), value: "eletro"));
    _categoryList.add(DropdownMenuItem(child: Text("Moda"), value: "moda"));
    _categoryList
        .add(DropdownMenuItem(child: Text("Esportes"), value: "esportes"));
  }
}

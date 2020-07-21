import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber/component/dialog_helper.dart';
import 'package:uber/mapper/placemark_address_mapper.dart';
import 'package:uber/services/active_request_service.dart';
import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/geolocator_service.dart';
import 'package:uber/services/model/active_request_model.dart';
import 'package:uber/services/model/address_model.dart';
import 'package:uber/services/model/request_model.dart';
import 'package:uber/services/request_service.dart';
import 'package:uber/store/store.dart';

class CallUber extends StatefulWidget {
  @override
  _CallUberState createState() => _CallUberState();
}

class _CallUberState extends State<CallUber> {

  TextEditingController _destinyController =
  new TextEditingController(text: "av. paulista, 807");
  GeolocatorService _geolocatorService = GeolocatorService();
  RequestService _requestService = RequestService();
  ActiveRequestService _activeRequestService = ActiveRequestService();

  _callUber() async {
    String destiny = _destinyController.text;
    Placemark placemark =
    await _geolocatorService.getFirstByDescription(destiny);

    if (placemark != null) {
      AddressModel addressModel = PlacemarkAddressMapper.Mapper(placemark);
      DialogHelper.yesNo(
          context,
          "Confirmação do endereço",
          addressModel.addressFormatted,
              () => _confirmedCallUber(addressModel));
    } else {
      DialogHelper.simple(context, "Ooops!", "Endereço não encontrado!");
    }
  }

  _confirmedCallUber(AddressModel address) async {
    RequestModel requestModel =
    RequestModel.newItem(address, null, Store.userModel, StatusEnum.WAIT);
    var uid = await _requestService.Create(requestModel);
    _activeRequestService.CreateOrUpdate(
        ActiveRequestModel(Store.userModel.uid, uid, StatusEnum.WAIT));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _textFieldPositioned(_textField(
          hintText: "Meu local",
          icon: Icons.location_on,
          iconColor: Colors.green,
          readOnly: true)),
      _textFieldPositioned(
          _textField(
              controller: _destinyController,
              hintText: "Digite o destino",
              icon: Icons.local_taxi,
              iconColor: Colors.black),
          top: 55.0),
      Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Padding(
              padding: Platform.isIOS
                  ? EdgeInsets.fromLTRB(20, 10, 20, 25)
                  : EdgeInsets.all(10),
              child: RaisedButton(
                  child: Text(
                    "Chamar Uber",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Color(0xff1ebbd8),
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: _callUber)))
    ]);
  }

  Widget _textFieldPositioned(Widget textField, {top = 0.0}) {
    return Positioned(
        top: top,
        left: 0,
        right: 0,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white),
                child: textField)));
  }

  Widget _textField(
      {hintText: "",
        icon: Icons.location_on,
        iconColor: Colors.black,
        readOnly: false,
        controller: null}) {
    return TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
            icon: Container(
                width: 10,
                margin: EdgeInsets.only(top: 0, left: 10),
                child: Icon(icon, color: iconColor)),
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 5, top: 0)));
  }

}

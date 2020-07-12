import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber/core/services/auth_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/mapper/placemark_address.dart';
import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/model/address_model.dart';
import 'package:uber/services/model/request_model.dart';
import 'package:uber/services/request_service.dart';
import 'package:uber/services/user_service.dart';
import 'package:uber/store/store.dart';

class PassangerPanel extends StatefulWidget {
  @override
  _PassangerPanelState createState() => _PassangerPanelState();
}

class _PassangerPanelState extends State<PassangerPanel> {
  Completer<GoogleMapController> _controller = Completer();
  AuthService _authService = AuthService();
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(-19.908138, -43.991582), zoom: 18);
  Set<Marker> _markers = {};
  TextEditingController _destinyController =
      new TextEditingController(text: "av. paulista, 807");
  RequestService _requestService = RequestService();

  _setCameraPositionByPosition(Position position) {
    _showMakerPassanger(position);

    setState(() {
      _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 18);
    });

    _goToCameraPosition();
  }

  var _itemsMenu = ["Configurações", "Deslogar"];

  _onSelectMenuItem(String selectedItem) {
    switch (selectedItem) {
      case "Configurações":
        _config();
        break;
      case "Deslogar":
        _logout();
        break;
    }
  }

  _config() {}

  _logout() {
    _authService.Logout();
    Navigator.pushReplacementNamed(context, "/");
  }

  _getLastKnownPosition() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      _setCameraPositionByPosition(position);
    }
  }

  _listenerPosition() async {
    await Geolocator()
        .getPositionStream(LocationOptions(
            accuracy: LocationAccuracy.high, distanceFilter: 10))
        .listen((Position position) {
      _setCameraPositionByPosition(position);
    });
  }

  _showMakerPassanger(Position local) async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
                devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
            "assets/images/passageiro.png")
        .then((icon) {
      Marker marker = Marker(
          markerId: MarkerId("marker-passanger"),
          position: LatLng(local.latitude, local.longitude),
          infoWindow: InfoWindow(title: "Meu local"),
          icon: icon);

      setState(() {
        _markers.add(marker);
      });
    });
  }

  _confirmedCallUber(contex, address) async {
    AddressModel addressModel = PlacemarkAddress.Mapper(address);
    RequestModel requestModel = RequestModel.newItem(
        addressModel, null, Store.userModel, StatusEnum.wait);
    await _requestService.Create(requestModel);
    Navigator.pop(contex);
  }

  _callUber() async {

    String destiny = _destinyController.text;

    if (destiny.isNotEmpty) {

      List<Placemark> addressList =
          await Geolocator().placemarkFromAddress(destiny);
      
      if (addressList != null && addressList.length > 0) {
        Placemark address = addressList[0];

        String addressFormatted;
        addressFormatted = "\n Cidade: " + address.administrativeArea;
        addressFormatted +=
            "\n Rua: " + address.thoroughfare + ", " + address.subThoroughfare;
        addressFormatted += "\n Bairro: " + address.subLocality;
        addressFormatted += "\n Cep: " + address.postalCode;

        showDialog(
            context: context,
            builder: (contex) {
              return AlertDialog(
                  title: Text("Confirmação do endereço"),
                  content: Text(addressFormatted),
                  contentPadding: EdgeInsets.all(16),
                  actions: <Widget>[
                    FlatButton(
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () => Navigator.pop(contex)),
                    FlatButton(
                        child: Text("Confirmar",
                            style: TextStyle(color: Colors.green)),
                        onPressed: () => _confirmedCallUber(contex, address))
                  ]);
            });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getLastKnownPosition();
    _listenerPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Passageiro"), actions: [
          PopupMenuButton(
              onSelected: _onSelectMenuItem,
              itemBuilder: (context) {
                return _itemsMenu.map((String item) {
                  return PopupMenuItem(value: item, child: Text(item));
                }).toList();
              })
        ]),
        body: Container(
            child: Stack(children: [
          GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers),
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
        ])));
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

  Future<void> _goToCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }
}

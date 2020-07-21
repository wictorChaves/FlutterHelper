import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/component/dialog_helper.dart';
import 'package:uber/mapper/placemark_address_mapper.dart';
import 'package:uber/screens/shared/default_popup_menu.dart';
import 'package:uber/services/active_request_service.dart';
import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/geolocator_service.dart';
import 'package:uber/services/model/active_request_model.dart';
import 'package:uber/services/model/address_model.dart';
import 'package:uber/services/model/request_model.dart';
import 'package:uber/services/request_service.dart';
import 'package:uber/store/store.dart';

class PassangerPanel extends StatefulWidget {
  @override
  _PassangerPanelState createState() => _PassangerPanelState();
}

class _PassangerPanelState extends State<PassangerPanel> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(-19.908138, -43.991582), zoom: 18);
  Set<Marker> _markers = {};
  TextEditingController _destinyController =
      new TextEditingController(text: "av. paulista, 807");
  RequestService _requestService = RequestService();
  ActiveRequestService _activeRequestService = ActiveRequestService();
  GeolocatorService _geolocatorService = GeolocatorService();
  ActiveRequestModel _activeRequestModel = null;

  _setCameraPositionByPosition(Position position) {
    _showMakerPassanger(position);

    setState(() {
      _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 18);
    });

    _goToCameraPosition();
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

  _cancelUber() async {
    DialogHelper.yesNo(
        context,
        "Cancelar",
        "Deseja cancelar a corrida?",
        () => _activeRequestService.UpdateProperty(_activeRequestModel,
            {'status': enumToDescribe(StatusEnum.FINISHED)}));
  }

  _confirmedCallUber(AddressModel address) async {
    RequestModel requestModel =
        RequestModel.newItem(address, null, Store.userModel, StatusEnum.WAIT);
    var uid = await _requestService.Create(requestModel);
    _activeRequestService.CreateOrUpdate(
        ActiveRequestModel(Store.userModel.uid, uid, StatusEnum.WAIT));
  }

  _getActiveRequest() async {
    _activeRequestService.ListenById(Store.userModel.uid).listen((event) {
      setState(() {
        _activeRequestModel = (event.data == null)
            ? null
            : ActiveRequestModel.fromJson(event.data);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _geolocatorService
        .setLastKnownPositionAndlistener(_setCameraPositionByPosition);
    _getActiveRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text("Passageiro"), actions: [DefaultPopupMenu()]),
        body: Container(
            child: Stack(children: [
          GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _cameraPosition,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              }),
          ..._view()
        ])));
  }

  List<Widget> _view() {
    if (_activeRequestModel == null) {
      return _callUberView();
    }
    switch (_activeRequestModel.status) {
      case StatusEnum.WAIT:
        return _waitUberView();
      case StatusEnum.ON_MY_WAY:
        return _onMyWayUberView();
      case StatusEnum.TRAVELING:
        return _travelingUberView();
      case StatusEnum.FINISHED:
        return _callUberView();
    }
    return _callUberView();
  }

  List<Widget> _callUberView() {
    return [
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
    ];
  }

  List<Widget> _waitUberView() {
    return [
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
                    "Cancelar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.red,
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: _cancelUber)))
    ];
  }

  List<Widget> _onMyWayUberView() {
    return [];
  }

  List<Widget> _travelingUberView() {
    return [];
  }

  List<Widget> _finishedUberView() {
    return [];
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

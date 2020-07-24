import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/mapper/position_lat_lng_mapper.dart';
import 'package:uber/screens/running/running_camera_update.dart';
import 'package:uber/services/active_request_service.dart';
import 'package:uber/services/geolocator_service.dart';
import 'package:uber/services/model/active_request_model.dart';
import 'package:uber/services/model/request_model.dart';
import 'package:uber/services/request_service.dart';
import 'package:uber/store/store.dart';

class PassagerMap extends StatefulWidget {
  @override
  _PassagerMapState createState() => _PassagerMapState();
}

class _PassagerMapState extends State<PassagerMap> {
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  GeolocatorService _geolocatorService = GeolocatorService();
  RequestService _requestService = RequestService();
  ActiveRequestService _activeRequestService = ActiveRequestService();
  RequestModel _requestModel = null;

  _listenerPosition(Position position) {
    _updateDBPosition(position);
  }

  _updateDBPosition(Position position) async {
    if (_requestModel != null) {
      RequestModel requestModel =
          await _requestService.GetById(_requestModel.uid);
      requestModel.passanger.fromPosition = position;
      _requestService.CreateOrUpdate(requestModel);
    }
  }

  _listenPosition() async {
    ActiveRequestModel activeRequestModel =
        await _activeRequestService.GetById(Store.userModel.uid);
    _requestService.ListenById(activeRequestModel.uid_request).listen((data) {
      _requestModel = RequestModel.fromJson(data.data);
      if (_requestModel.driver != null)
        _showMaker(_requestModel.driver.positionToPosition, "motorista");
      _showMaker(_requestModel.passanger.positionToPosition, "passageiro");
    });
  }

  @override
  void initState() {
    super.initState();
    _geolocatorService.setLastKnownPositionAndlistener(_listenerPosition);
    _listenPosition();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(-19.908138, -43.991582), zoom: 18),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        });
  }

  _showMaker(Position position, String type) {
    _loadImages(type).then((image) {
      setState(() {
        _markers.add(_customMaker(position, image, type));
      });
      _goToCameraPosition();
    });
  }

  Future<void> _goToCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    if (_requestModel != null) {
      CameraUpdate cameraUpdate =
          RunningCameraUpdate.GetCameraUpdate(_requestModel);
      if (cameraUpdate != null) {
        controller.animateCamera(cameraUpdate);
      }
    }
  }

  Marker _customMaker(Position position, BitmapDescriptor image, String type) {
    return Marker(
        markerId: MarkerId("marker-$type"),
        position: PositionLatLngMapper.ToLatLng(position),
        infoWindow: InfoWindow(title: type),
        icon: image);
  }

  Future<BitmapDescriptor> _loadImages(String image) {
    return BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
            devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
        "assets/images/${image}.png");
  }
}

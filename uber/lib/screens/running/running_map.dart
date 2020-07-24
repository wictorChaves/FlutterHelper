import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/services/geolocator_service.dart';
import 'package:uber/services/model/request_model.dart';

class RunningMap extends StatefulWidget {
  RequestModel requestModel;

  RunningMap(this.requestModel);

  @override
  _RunningMapState createState() => _RunningMapState();
}

class _RunningMapState extends State<RunningMap> {
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(-19.908138, -43.991582), zoom: 18);
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  GeolocatorService _geolocatorService = GeolocatorService();

  setCameraPositionByPosition(Position position) {
    _showMakerDriver(position);
    _showMakerPassanger();

    setState(() {
      _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 18);
    });

    _goToCameraPosition();
  }

  _showMakerDriver(Position local) async {
    _showMaker(local, "motorista");
  }

  _showMakerPassanger() async {
    final List<double> position = widget.requestModel.destiny.position
        .split(",")
        .map((e) => double.parse(e))
        .toList();

    Position local = Position(
      latitude: position[0],
      longitude: position[1],
    );

    _showMaker(local, "passageiro");
  }

  _showMaker(Position local, String type) {
    _loadImages(type).then((image) {
      setState(() {
        _markers.add(_customMaker(local, image, type));
      });
    });
  }

  Future<void> _goToCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  _setMarkers() async {
    _geolocatorService
        .setLastKnownPositionAndlistener(setCameraPositionByPosition);
  }

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _cameraPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        });
  }

  Marker _customMaker(Position local, BitmapDescriptor image, String type) {
    return Marker(
        markerId: MarkerId("marker-$type"),
        position: LatLng(local.latitude, local.longitude),
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

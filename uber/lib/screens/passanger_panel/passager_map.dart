import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/services/geolocator_service.dart';

class PassagerMap extends StatefulWidget {
  @override
  _PassagerMapState createState() => _PassagerMapState();
}

class _PassagerMapState extends State<PassagerMap> {
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(-19.908138, -43.991582), zoom: 18);
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  GeolocatorService _geolocatorService = GeolocatorService();

  setCameraPositionByPosition(Position position) {
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

  Future<void> _goToCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  @override
  void initState() {
    super.initState();
    _geolocatorService
        .setLastKnownPositionAndlistener(setCameraPositionByPosition);
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
}

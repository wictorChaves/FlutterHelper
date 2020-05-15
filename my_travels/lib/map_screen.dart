import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mytravels/services/model/travel_model.dart';
import 'dart:async';

import 'package:mytravels/services/travel_service.dart';

class MapScreen extends StatefulWidget {
  TravelModel travel;

  MapScreen({this.travel});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TravelService _travelService = TravelService();
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 18,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _setMark(LatLng latLng) async {
    List<Placemark> listAddress = await Geolocator()
        .placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    if (listAddress != null && listAddress.length > 0) {
      Placemark address = listAddress[0];
      String street = address.thoroughfare;
      Marker mark = Marker(
          markerId: MarkerId("mark-${latLng.latitude}-${latLng.longitude}"),
          position: latLng,
          infoWindow: InfoWindow(title: street));
      setState(() {
        _markers.add(mark);
        _travelService.Create(TravelModel.fromJson({
          "title": street,
          "latitude": latLng.latitude,
          "longitude": latLng.longitude
        }));
      });
    }
  }

  _moveCam() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  _addListenerLocation() {
    Geolocator geolocator = Geolocator();
    LocationOptions locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high);
    geolocator.getPositionStream(locationOptions).listen((Position position) {
      setState(() {
        _cameraPosition = _getCameraPosition(LatLng(position.latitude, position.longitude));
        _moveCam();
      });
    });
  }

  void _getTravel(TravelModel travel) async {
    if (travel == null) {
      _addListenerLocation();
    } else {
      LatLng latLng = LatLng(travel.latitude, travel.longitude);
      Marker mark = Marker(
          markerId: MarkerId("mark-${latLng.latitude}-${latLng.longitude}"),
          position: latLng,
          infoWindow: InfoWindow(title: travel.title));
      setState(() {
        _markers.add(mark);
        _cameraPosition = _getCameraPosition(latLng);
        _moveCam();
      });
    }
  }

  _getCameraPosition(LatLng latLng) {
    return CameraPosition(target: latLng, zoom: 18);
  }

  @override
  void initState() {
    super.initState();
    _getTravel(widget.travel);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Mapa")),
        body: Container(
            child: GoogleMap(
                markers: _markers,
                mapType: MapType.normal,
                initialCameraPosition: _cameraPosition,
                onMapCreated: _onMapCreated,
                onLongPress: _setMark)));
  }
}

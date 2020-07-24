import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/mapper/position_lat_lng_mapper.dart';
import 'package:uber/screens/running/running_camera_update.dart';
import 'package:uber/services/geolocator_service.dart';
import 'package:uber/services/model/request_model.dart';
import 'package:uber/services/request_service.dart';

class RunningMap extends StatefulWidget {
  RequestModel requestModel;

  RunningMap(this.requestModel);

  @override
  _RunningMapState createState() => _RunningMapState();
}

class _RunningMapState extends State<RunningMap> {
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  GeolocatorService _geolocatorService = GeolocatorService();
  RequestService _requestService = RequestService();

  _listenerPosition(Position position) {
    _updateDBPosition(position);
  }

  _updateDBPosition(Position position) {
    if (widget.requestModel.driver != null) {
      widget.requestModel.driver.fromPosition = position;
      _requestService.CreateOrUpdate(widget.requestModel);
    }
  }

  @override
  void initState() {
    super.initState();
    _geolocatorService.setLastKnownPositionAndlistener(_listenerPosition);
    _requestService.ListenById(widget.requestModel.uid).listen((data) {
      RequestModel requestModel = RequestModel.fromJson(data.data);
      widget.requestModel = requestModel;
      if (requestModel.driver != null)
        _showMaker(requestModel.driver.positionToPosition, "motorista");
      _showMaker(requestModel.passanger.positionToPosition, "passageiro");
    });
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
    CameraUpdate cameraUpdate = RunningCameraUpdate.GetCameraUpdate(widget.requestModel);
    if (cameraUpdate != null) {
      controller.animateCamera(cameraUpdate);
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

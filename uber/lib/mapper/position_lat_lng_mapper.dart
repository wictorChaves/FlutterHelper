import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PositionLatLngMapper {
  static LatLng ToLatLng(Position position) {
    return LatLng(position.latitude, position.longitude);
  }

  static Position ToPosition(LatLng latLng) {
    return Position(latitude: latLng.latitude, longitude: latLng.longitude);
  }
}

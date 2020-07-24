import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/services/model/request_model.dart';

class RunningCameraUpdate {
  static CameraUpdate GetCameraUpdate(RequestModel requestModel) {
    if (requestModel.driver == null) {
      return CameraUpdate.newCameraPosition(CameraPosition(
          target: requestModel.passanger.positionToLatLng, zoom: 18));
    } else {
      return CameraUpdate.newLatLngBounds(
          _getLatLngBounds(requestModel.passanger.positionToLatLng,
              requestModel.driver.positionToLatLng),
          100);
    }
  }

  static LatLngBounds _getLatLngBounds(LatLng northeast, LatLng southWest) {
    double sLat = northeast.latitude;
    double nLat = southWest.latitude;

    double sLon = northeast.longitude;
    double nLon = southWest.longitude;

    if (northeast.latitude > southWest.latitude) {
      sLat = southWest.latitude;
      nLat = northeast.latitude;
    }

    if (northeast.longitude > southWest.longitude) {
      sLon = southWest.longitude;
      nLon = northeast.longitude;
    }

    return LatLngBounds(
        northeast: LatLng(nLat, nLon), //nordeste
        southwest: LatLng(sLat, sLon) //sudoeste
        );
  }
}

import 'package:geolocator/geolocator.dart';
import 'package:uber/services/model/address_model.dart';

class PlacemarkAddressMapper {
  static AddressModel Mapper(Placemark placemark) {
    Map<String, dynamic> placemarkJson = placemark.toJson();
    placemarkJson['position'] = placemark.position.latitude.toString() +
        "," +
        placemark.position.longitude.toString();
    return AddressModel.fromJson(placemarkJson);
  }
}

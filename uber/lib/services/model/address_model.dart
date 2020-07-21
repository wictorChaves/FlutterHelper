import 'package:uber/core/services/model/imodel.dart';

class AddressModel implements IModel {
  @override
  String uid;

  String _name;
  String _isoCountryCode;
  String _country;
  String _postalCode;
  String _administrativeArea;
  String _subAdministrativeArea;
  String _locality;
  String _subLocality;
  String _thoroughfare;
  String _subThoroughfare;
  String _position;

  @override
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": _name,
        "isoCountryCode": _isoCountryCode,
        "country": _country,
        "postalCode": _postalCode,
        "administrativeArea": _administrativeArea,
        "subAdministrativeArea": _subAdministrativeArea,
        "locality": _locality,
        "subLocality": _subLocality,
        "thoroughfare": _thoroughfare,
        "subThoroughfare": _subThoroughfare,
        "position": _position
      };

  @override
  AddressModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    _name = json["name"];
    _isoCountryCode = json["isoCountryCode"];
    _country = json["country"];
    _postalCode = json["postalCode"];
    _administrativeArea = json["administrativeArea"];
    _subAdministrativeArea = json["subAdministrativeArea"];
    _locality = json["locality"];
    _subLocality = json["subLocality"];
    _thoroughfare = json["thoroughfare"];
    _subThoroughfare = json["subThoroughfare"];
    _position = json["position"];
  }

  AddressModel(
      this.uid,
      this._name,
      this._isoCountryCode,
      this._country,
      this._postalCode,
      this._administrativeArea,
      this._subAdministrativeArea,
      this._locality,
      this._subLocality,
      this._thoroughfare,
      this._subThoroughfare,
      this._position);

  AddressModel.newAddress(
      this._name,
      this._isoCountryCode,
      this._country,
      this._postalCode,
      this._administrativeArea,
      this._subAdministrativeArea,
      this._locality,
      this._subLocality,
      this._thoroughfare,
      this._subThoroughfare,
      this._position);

  String get position => _position;

  set position(String value) {
    _position = value;
  }

  String get subThoroughfare => _subThoroughfare;

  set subThoroughfare(String value) {
    _subThoroughfare = value;
  }

  String get thoroughfare => _thoroughfare;

  set thoroughfare(String value) {
    _thoroughfare = value;
  }

  String get subLocality => _subLocality;

  set subLocality(String value) {
    _subLocality = value;
  }

  String get locality => _locality;

  set locality(String value) {
    _locality = value;
  }

  String get subAdministrativeArea => _subAdministrativeArea;

  set subAdministrativeArea(String value) {
    _subAdministrativeArea = value;
  }

  String get administrativeArea => _administrativeArea;

  set administrativeArea(String value) {
    _administrativeArea = value;
  }

  String get postalCode => _postalCode;

  set postalCode(String value) {
    _postalCode = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get isoCountryCode => _isoCountryCode;

  set isoCountryCode(String value) {
    _isoCountryCode = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get city => _subAdministrativeArea;

  String get state => _administrativeArea;

  set city(String value) {
    _administrativeArea = value;
  }

  String get neighborhood => _subLocality;

  set neighborhood(String value) {
    _subLocality = value;
  }

  String get street => _thoroughfare;

  set street(String value) {
    _thoroughfare = value;
  }

  String get number => _subThoroughfare;

  set number(String value) {
    _subThoroughfare = value;
  }

  String get addressFormatted =>
      "${street}, ${number} - ${postalCode}\n${neighborhood}, ${city} - ${state}";
}

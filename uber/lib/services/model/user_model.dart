import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/services/model/imodel.dart';

class UserModel implements IModel {
  @override
  String uid;

  String _name;
  String _email;
  bool _isDriver;
  String _position;

  UserModel(this.uid, this._name, this._email, this._isDriver, this._position);

  @override
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "isDriver": isDriver,
        "position": position
      };

  @override
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    name = json["name"];
    email = json["email"];
    isDriver = json["isDriver"];
    position = json["position"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  bool get isDriver => _isDriver;

  set isDriver(bool value) {
    _isDriver = value;
  }

  String get position => _position;

  set position(String value) {
    _position = value;
  }

  set fromPosition(Position position) {
    _position =
        position.latitude.toString() + "," + position.longitude.toString();
  }

  Position get positionToPosition {
    final List<double> positionList =
        position.split(",").map((e) => double.parse(e)).toList();

    return Position(latitude: positionList[0], longitude: positionList[1]);
  }

  LatLng get positionToLatLng {
    final List<double> positionList =
        position.split(",").map((e) => double.parse(e)).toList();

    return LatLng(positionList[0], positionList[1]);
  }
}

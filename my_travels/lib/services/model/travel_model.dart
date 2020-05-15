import 'package:mytravels/services/model/imodel.dart';

class TravelModel implements IModel {
  @override
  String uid;
  String _title;
  double _latitude;
  double _longitude;

  @override
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "title": _title,
        "latitude": _latitude,
        "longitude": _longitude
      };

  @override
  TravelModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    _title = json["title"];
    _latitude = json["latitude"];
    _longitude = json["longitude"];
  }

  double get longitude => _longitude;
  set longitude(double value) {
    _longitude = value;
  }

  double get latitude => _latitude;
  set latitude(double value) {
    _latitude = value;
  }

  String get title => _title;
  set title(String value) {
    _title = value;
  }
}

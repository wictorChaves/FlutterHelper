import 'package:whatsapp/services/model/imodel.dart';

class UserModel implements IModel {

  @override
  String uid;

  String _name;
  String _email;

  @override
  Map<String, dynamic> toJson() => {"name": _name, "email": _email};

  @override
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    _name = json["name"];
    _email = json["email"];
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

}

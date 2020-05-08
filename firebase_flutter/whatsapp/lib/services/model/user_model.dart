import 'package:whatsapp/services/model/imodel.dart';

class UserModel implements IModel {
  @override
  String uid;

  String _name;
  String _email;
  String _urlImage;

  UserModel(this.uid, this._name, this._email, this._urlImage);

  @override
  Map<String, dynamic> toJson() =>
      {"name": _name, "email": _email, "urlImage": _urlImage};

  @override
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    _name = json["name"];
    _email = json["email"];
    _urlImage = json["urlImage"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get urlImage => _urlImage;

  set urlImage(String value) {
    _urlImage = value;
  }
}

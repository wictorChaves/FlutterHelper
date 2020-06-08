import '../../core/services/model/imodel.dart';

class UserModel implements IModel {
  @override
  String uid;

  String _name;
  String _email;
  bool _isDriver;

  UserModel(this.uid, this._name, this._email, this._isDriver);

  @override
  Map<String, dynamic> toJson() =>
      {"uid": uid, "name": _name, "email": _email, "isDriver": _isDriver};

  @override
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    _name = json["name"];
    _email = json["email"];
    _isDriver = json["isDriver"];
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
}
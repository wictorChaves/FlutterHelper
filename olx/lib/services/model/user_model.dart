import '../../core/services/model/imodel.dart';

class UserModel implements IModel {
  @override
  String uid;

  String _name;
  String _email;

  UserModel(this.uid, this._name, this._email);

  @override
  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "email": email
  };

  @override
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    name = json["name"];
    email = json["email"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

}

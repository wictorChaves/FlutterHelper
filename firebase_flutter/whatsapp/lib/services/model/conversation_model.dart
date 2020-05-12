import 'package:whatsapp/services/model/imodel.dart';
import 'package:whatsapp/services/model/user_model.dart';

class ConversationModel implements IModel {
  @override
  String uid;

  UserModel _user;
  String _message;
  String _urlImage;
  int _created;

  ConversationModel(this.uid, this._user, this._message) {
    this._created = new DateTime.now().millisecondsSinceEpoch;
  }

  UserModel get user => _user;
  set user(UserModel value) {
    _user = value;
  }

  int get created => _created;
  set created(int value) {
    _created = value;
  }

  String get message => _message;
  set message(String value) {
    _message = value;
  }

  String get urlImage => _urlImage;
  set urlImage(String value) {
    _urlImage = value;
  }

  @override
  Map<String, dynamic> toJson() => {
        "user": _user.toJson(),
        "message": _message,
        "urlImage": _urlImage,
        "created": _created
      };

  @override
  ConversationModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    _user = UserModel.fromJson(json["user"]);
    _message = json["message"];
    _urlImage = json["urlImage"];
    _created = json["created"];
  }

  @override
  ConversationModel.Send(UserModel user, String message) {
    _user = user;
    _message = message;
    _urlImage = user.urlImage;
    this._created = new DateTime.now().millisecondsSinceEpoch;
  }
}

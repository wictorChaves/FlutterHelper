import 'package:whatsapp/global/main_global.dart';
import 'package:whatsapp/services/model/imodel.dart';

class MessageModel implements IModel {
  @override
  String uid;

  String _uidUser;
  String _message;
  String _urlImage;
  String _type;
  int _created;

  MessageModel.Send(this._message, this._urlImage, this._type) {
    _uidUser = MainGlobal.userModel.uid;
    this._created = new DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Map<String, dynamic> toJson() => {
        "uidUser": _uidUser,
        "message": _message,
        "urlImage": _urlImage,
        "type": _type,
        "created": _created
      };

  @override
  MessageModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    _uidUser = json["uidUser"];
    _message = json["message"];
    _urlImage = json["urlImage"];
    _type = json["type"];
    _created = json["created"];
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get urlImage => _urlImage;

  set urlImage(String value) {
    _urlImage = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get uidUser => _uidUser;

  set uidUser(String value) {
    _uidUser = value;
  }
}

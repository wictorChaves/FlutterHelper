import 'package:uber/services/enum/status_enum.dart';

import '../../core/services/model/imodel.dart';

class ActiveRequestModel implements IModel {
  @override
  String uid;

  String _uid_user;
  StatusEnum _status;

  @override
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uid_user": _uid_user,
        "status": enumToDescribe(_status),
      };

  @override
  ActiveRequestModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    _uid_user = json["uid_user"];
    _status = describeToEnum(json["status"]);
  }

  ActiveRequestModel(this.uid, this._uid_user, this._status);

  ActiveRequestModel.newItem(this._uid_user, this._status);

  StatusEnum get status => _status;

  set status(StatusEnum value) {
    _status = value;
  }

  String get uid_user => _uid_user;

  set uid_user(String value) {
    _uid_user = value;
  }
}

import 'package:uber/services/enum/status_enum.dart';

import '../../core/services/model/imodel.dart';

class ActiveRequestModel implements IModel {
  @override
  String uid;

  String _uid_request;
  StatusEnum _status;

  @override
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uid_request": _uid_request,
        "status": enumToDescribe(_status),
      };

  @override
  ActiveRequestModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    _uid_request = json["uid_request"];
    _status = describeToEnum(json["status"]);
  }

  ActiveRequestModel(this.uid, this._uid_request, this._status);

  ActiveRequestModel.newItem(this._uid_request, this._status);

  StatusEnum get status => _status;

  set status(StatusEnum value) {
    _status = value;
  }

  String get uid_request => _uid_request;

  set uid_request(String value) {
    _uid_request = value;
  }
}

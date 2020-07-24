import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/model/user_model.dart';

import '../../core/services/model/imodel.dart';
import 'address_model.dart';

class RequestModel implements IModel {
  @override
  String uid;

  AddressModel _destiny;
  UserModel _driver;
  UserModel _passanger;
  StatusEnum _status;

  @override
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "destiny": _destiny.toJson(),
        "driver": (_driver == null) ? null : _driver.toJson(),
        "passanger": _passanger.toJson(),
        "status": enumToDescribe(_status),
      };

  @override
  RequestModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    _destiny =
        json["destiny"] == null ? null : AddressModel.fromJson(json["destiny"]);
    _driver =
        json["driver"] == null ? null : UserModel.fromJson(json["driver"]);
    _passanger = json["passanger"] == null
        ? null
        : UserModel.fromJson(json["passanger"]);
    _status = describeToEnum(json["status"]);
  }

  RequestModel(
      this.uid, this._destiny, this._driver, this._passanger, this._status);

  RequestModel.newItem(
      this._destiny, this._driver, this._passanger, this._status);

  StatusEnum get status => _status;

  set status(StatusEnum value) {
    _status = value;
  }

  UserModel get passanger => _passanger;

  set passanger(UserModel value) {
    _passanger = value;
  }

  UserModel get driver => _driver;

  set driver(UserModel value) {
    _driver = value;
  }

  AddressModel get destiny => _destiny;

  set destiny(AddressModel value) {
    _destiny = value;
  }
}

import 'package:olx/core/services/model/imodel.dart';

class TestModel implements IModel {
  @override
  String uid;

  String _name;

  TestModel(this.uid, this._name);

  TestModel.create(this._name);

  @override
  Map<String, dynamic> toJson() => {"uid": uid, "name": name};

  @override
  TestModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    name = json["name"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}

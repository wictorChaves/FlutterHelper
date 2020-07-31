abstract class IModel {
  String _uid;

  Map<String, dynamic> toJson();

  IModel.fromJson(Map<String, dynamic> json);

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }
}
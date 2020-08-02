import '../../core/services/model/imodel.dart';

class AdvertModel implements IModel {
  @override
  String uid;

  String _state;
  String _category;
  String _title;
  String _price;
  String _phone;
  String _description;
  List<String> _images = [];

  AdvertModel.empty();

  AdvertModel(this.uid, this._state, this._category, this._title, this._price,
      this._phone, this._description, this._images);

  AdvertModel.fromAdd(this._state, this._category, this._title, this._price,
      this._phone, this._description, this._images);

  @override
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "state": state,
        "category": category,
        "title": title,
        "price": price,
        "phone": phone,
        "description": description,
        "images": images,
      };

  @override
  AdvertModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    state = json["state"];
    category = json["category"];
    title = json["title"];
    price = json["price"];
    phone = json["phone"];
    description = json["description"];
    images = json["images"];
  }

  addImage(String value) {
    _images.add(value);
  }

  List<String> get images => _images;

  set images(List<String> value) {
    _images = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  String get state => _state;

  set state(String value) {
    _state = value;
  }
}

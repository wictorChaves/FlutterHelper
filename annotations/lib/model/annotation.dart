import 'package:annotations/helper/datetime_helper.dart';

class Annotation {
  int _id;
  String _title;
  String _content;
  DateTime _create_datetime;
  DateTime _update_datetime;

  Annotation(this._id, this._title, this._content, this._create_datetime,
      this._update_datetime);

  Annotation.New(String title, String content) {
    this._title = title;
    this._content = content;
    this._create_datetime = DateTime.now();
    this._update_datetime = DateTime.now();
  }

  String get content => _content;

  set content(String value) {
    this._update_datetime = DateTime.now();
    _content = value;
  }

  String get title => _title;

  set title(String value) {
    this._update_datetime = DateTime.now();
    _title = value;
  }

  int get id => _id;

  DateTime get create_datetime => _create_datetime;

  set create_datetime(DateTime value) {
    _create_datetime = value;
  }

  DateTime get update_datetime => _update_datetime;

  set update_datetime(DateTime value) {
    _update_datetime = value;
  }

  String getUpdateDatetimeDateBr() =>
      DatetimeHelper(_update_datetime).ToBRDateString();

  Annotation.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _title = json['title'],
        _content = json['content'],
        _create_datetime =
            DateTime.fromMillisecondsSinceEpoch(json['create_datetime']),
        _update_datetime =
            DateTime.fromMillisecondsSinceEpoch(json['update_datetime']);

  Map<String, dynamic> toJson() => {
        'id': _id,
        'title': _title,
        'content': _content,
        'create_datetime': _create_datetime.millisecondsSinceEpoch,
        'update_datetime': _update_datetime.millisecondsSinceEpoch
      };
}

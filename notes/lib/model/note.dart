import 'dart:convert';

class Note {
  int _id;
  String _title;
  String _content;

  Note(this._id, this._title, this._content);

  Note.Simple(String title, String content) {
    _title = title;
    _content = content;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Note.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _content = json['content'];
  }

  Map<String, dynamic> toJson() => {
    'id': _id ?? 0,
    'title': _title,
    'content': _content,
  };

  String toString() => JsonEncoder.withIndent("").convert(this.toJson());

}

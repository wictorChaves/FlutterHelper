import 'dart:convert';

class Task {
  String _title;
  bool _done;

  Task(this._title, this._done);

  bool get done => _done;

  set done(bool value) {
    _done = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  Task.fromJson(Map<String, dynamic> json)
      : _title = json['title'],
        _done = json['bool'] == 'true';

  Map<String, dynamic> toJson() => {
        'title': _title.toString(),
        'bool': _done.toString(),
      };
}

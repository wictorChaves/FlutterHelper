import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:notes/main_settings.dart';
import 'package:notes/model/note.dart';

class NoteService {
  String _mainUrl = MainSettings.ServiceUrl;

  Future<Response> GetById(int id) {
    return http.get(_mainUrl + "notes/" + id.toString());
  }

  Future<Response> Get() {
    return http.get(_mainUrl + "notes");
  }

  Future<Response> Put(Note item) {
    print(item.toString());
    return http.put(_mainUrl + "notes/" + item.id.toString(),
        body: item.toString(),
        headers: {"Content-type": "application/json; charset=UTF-8"});
  }

  Future<Response> Post(Note item) {
    print(item.toJson());
    return http.post(_mainUrl + "notes/",
        body: item.toString(),
        headers: {"Content-type": "application/json; charset=UTF-8"});
  }

  Future<Response> Delete(int id) {
    return http.delete(_mainUrl + "notes/" + id.toString());
  }
}

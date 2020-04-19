import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:tasklist/model/task.dart';

class TaskService {
  Future<File> GetFile() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String pathFile = "${directory.path}/data.json";
      var fileExist = await File(pathFile).exists();
      if (fileExist == false) new File(pathFile).create(recursive: true);
      return File(pathFile);
    } catch (e) {
      return null;
    }
  }

  Future<String> ReadFile() async {
    File file = await GetFile();
    return await file.readAsString();
  }

  void Save(List<Task> tasklist) async {
    try {
      var file = await GetFile();
      file.writeAsString(json.encode(tasklist));
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  Future<List<Task>> GetAll() async {
    try {
      String data = await ReadFile();
      List<dynamic> listDynamic = jsonDecode(data).toList();
      return listDynamic.map((item) => Task.fromJson(item)).toList();
    } catch (e) {
      print("Error: " + e.toString());
    }
  }
}

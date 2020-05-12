import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage _storage;
  String _path = "images";

  StorageService(String path) {
    _storage = FirebaseStorage.instance;
    _path = path;
  }

  StorageUploadTask SetFile(File image, String name) {
    StorageReference file = _storage.ref().child(_path).child(name);
    return file.putFile(image);
  }

  StorageUploadTask SetFileInFolder(File image, String name, String folder) {
    StorageReference file =
        _storage.ref().child(_path).child(folder).child(name);
    return file.putFile(image);
  }
}

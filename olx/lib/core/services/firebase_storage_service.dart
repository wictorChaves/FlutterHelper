import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  Future<dynamic> Upload(File file,
      {String imageName = null, String path = ""}) async {
    if (imageName == null) {
      imageName = DateTime.now().millisecondsSinceEpoch.toString();
    }
    StorageReference storageReference = GetStorageReference(path);
    storageReference = storageReference.child(imageName);

    StorageUploadTask uploadTask = storageReference.putFile(file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    return await taskSnapshot.ref.getDownloadURL();
  }

  GetStorageReference(String path) {
    List<String> paths = path.split("/").where((p) => p.isNotEmpty).toList();
    StorageReference storageReference = GetRootPath();
    for (String path in paths) {
      storageReference = storageReference.child(path);
    }
    return storageReference;
  }

  GetRootPath() {
    return FirebaseStorage.instance.ref();
  }
}

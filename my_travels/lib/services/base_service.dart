import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mytravels/services/model/imodel.dart';

import 'firestore_service.dart';

class BaseService<T extends IModel> extends FirestoreService {
  Function(Map<String, dynamic> json) _newInstance;

  BaseService(String path, Function(Map<String, dynamic> json) newInstance)
      : super(path) {
    _newInstance = newInstance;
  }

  @override
  Future<List<T>> GetAll() async {
    List<DocumentSnapshot> documentSnapshotList = await GetAllDocuments();
    return documentSnapshotList.map((item) => _fromJson(item)).toList();
  }

  Future<T> GetById(String id) async {
    return _fromJson(await GetDocumentById(id));
  }

  Future<String> Create(T model) async =>
      (await CreateDocument(model.toJson())).documentID;

  Future<dynamic> CreateOrUpdate(T model) => model.uid == null
      ? Create(model)
      : CreateOrUpdateDocument(model.uid, model.toJson());

  Future<dynamic> UpdateProperty(T model, Map<String, dynamic> json) =>
      UpdatePropertyDocument(model.uid, json);

  Future<void> Delete(String id) => DeleteDocument(id);

  T _fromJson(DocumentSnapshot snapshot) {
    Map newItem = snapshot.data;
    newItem["uid"] = snapshot.documentID;
    return _newInstance(newItem);
  }
}
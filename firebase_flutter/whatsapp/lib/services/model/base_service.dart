import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/services/model/imodel.dart';

import '../firestore_service.dart';

class BaseService<T extends IModel> extends FirestoreService {
  BaseService(String path) : super(path);

  @override
  Future<List<T>> GetAll() async {
    List<DocumentSnapshot> documentSnapshotList = await GetAllDocuments();
    documentSnapshotList.map((item) => _fromJson(item));
  }

  Future<T> GetById(String id) async {
    return _fromJson(await GetDocumentById(id));
  }

  Future<String> Create(T model) async =>
      (await CreateDocument(model.toJson())).documentID;

  Future<String> CreateOrUpdate(T model) => model.uid == null
      ? Create(model)
      : CreateOrUpdateDocument(model.uid, model.toJson());

  Future<void> Delete(String id) => DeleteDocument(id);

  T _fromJson(DocumentSnapshot snapshot) {
    var newItem = snapshot.data;
    newItem["uid"] = snapshot.documentID;
    return T.fromJson(newItem);
  }
}

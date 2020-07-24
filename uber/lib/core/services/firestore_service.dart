import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference collection;

  FirestoreService(String path) {
    collection = Firestore.instance.collection(path);
  }

  Stream<QuerySnapshot> ListenAll() {
    return collection.snapshots();
  }

  Stream<DocumentSnapshot> ListenById(String id) {
    return collection.document(id).snapshots();
  }

  Future<List<DocumentSnapshot>> GetAllDocuments() async =>
      (await collection.getDocuments()).documents;

  Future<DocumentSnapshot> GetDocumentById(String id) =>
      collection.document(id).get();

  Future<String> CreateDocument(Map<String, dynamic> json) async {
    json["uid"] = collection.document().documentID;
    await CreateOrUpdateDocument(json["uid"], json);
    return json["uid"];
  }

  Future<void> CreateOrUpdateDocument(String id, Map<String, dynamic> json) =>
      collection.document(id).setData(json);

  Future<void> UpdatePropertyDocument(String id, Map<String, dynamic> json) =>
      collection.document(id).updateData(json);

  Future<void> DeleteDocument(String id) => collection.document(id).delete();
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference collection;

  FirestoreService(String path) {
    collection = Firestore.instance.collection(path);
  }

  Stream<QuerySnapshot> ListenAll() {
    return collection.snapshots();
  }

  Future<List<DocumentSnapshot>> GetAllDocuments() async =>
      (await collection.getDocuments()).documents;

  Future<DocumentSnapshot> GetDocumentById(String id) =>
      collection.document(id).get();

  Future<DocumentReference> CreateDocument(Map<String, dynamic> json) =>
      collection.add(json);

  Future<void> CreateOrUpdateDocument(String id, Map<String, dynamic> json) =>
      collection.document(id).setData(json);

  Future<void> UpdatePropertyDocument(String id, Map<String, dynamic> json) =>
      collection.document(id).updateData(json);

  Future<void> DeleteDocument(String id) => collection.document(id).delete();
}

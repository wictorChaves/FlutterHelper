import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference collection;

  FirestoreService(String path) {
    collection = Firestore.instance.collection(path);
  }

  Stream<QuerySnapshot> ListenAll(String id) {
    collection.snapshots();
  }

  Future<List<DocumentSnapshot>> GetAll() async =>
      (await collection.getDocuments()).documents;

  Future<DocumentSnapshot> GetById(String id) => collection.document(id).get();

  Future<DocumentReference> Create(Map<String, dynamic> json) =>
      collection.add(json);

  Future<void> CreateOrUpdate(String id, Map<String, dynamic> json) =>
      collection.document(id).setData(json);

  Future<void> Delete(String id) => collection.document(id).delete();
}

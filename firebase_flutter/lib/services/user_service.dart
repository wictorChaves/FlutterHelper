import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_service.dart';

class UserService extends FirestoreService {
  UserService(String path) : super("usuarios");
}

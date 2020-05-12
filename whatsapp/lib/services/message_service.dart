import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/global/main_global.dart';

import 'base_service.dart';
import 'model/message_model.dart';

class MessageService extends BaseService<MessageModel> {
  MessageService._constructor() : super("mensagens", NewInstance);

  static final MessageService _instance = MessageService._constructor();

  factory MessageService() {
    return _instance;
  }

  static MessageModel NewInstance(Map<String, dynamic> json) =>
      MessageModel.fromJson(json);

  Future<DocumentReference> SendMessage(
      String uidRecipient, MessageModel massageModel) async {

    await collection
        .document(MainGlobal.userModel.uid)
        .collection(uidRecipient)
        .add(massageModel.toJson());

    return collection
        .document(uidRecipient)
        .collection(MainGlobal.userModel.uid)
        .add(massageModel.toJson());
  }

  Stream<QuerySnapshot> GetMessages(String uidRecipient) {
    return collection
        .document(MainGlobal.userModel.uid)
        .collection(uidRecipient)
        .orderBy("created")
        .snapshots();
  }
}

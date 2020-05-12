import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/global/main_global.dart';

import 'base_service.dart';
import 'model/conversation_model.dart';
import 'model/user_model.dart';

class ConversationService extends BaseService<ConversationModel> {
  ConversationService._constructor() : super("conversas", NewInstance);

  static final ConversationService _instance =
      ConversationService._constructor();

  factory ConversationService() {
    return _instance;
  }

  static ConversationModel NewInstance(Map<String, dynamic> json) =>
      ConversationModel.fromJson(json);

  Future<void> SaveLastConversation(
      UserModel recipientUser, String massage) async {
    await collection
        .document(MainGlobal.userModel.uid)
        .collection("ultima_conversa")
        .document(recipientUser.uid)
        .setData(ConversationModel.Send(recipientUser, massage).toJson());

    collection
        .document(recipientUser.uid)
        .collection("ultima_conversa")
        .document(MainGlobal.userModel.uid)
        .setData(ConversationModel.Send(MainGlobal.userModel, massage).toJson());
  }

  Stream<QuerySnapshot> GetMessages() {
    return collection
        .document(MainGlobal.userModel.uid)
        .collection("ultima_conversa")
        .snapshots();
  }
}

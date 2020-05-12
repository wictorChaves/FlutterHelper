import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/helper/widget_helper.dart';
import 'package:whatsapp/services/conversation_service.dart';
import 'package:whatsapp/services/model/conversation_model.dart';
import '../tab_base.dart';

class Conversation extends TabBase {
  @override
  String Title = "Conversas";

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  ConversationService _conversationService;
  StreamController<QuerySnapshot> streamController =
      StreamController<QuerySnapshot>.broadcast();

  _ConversationState() {
    _conversationService = ConversationService();
  }

  @override
  void initState() {
    super.initState();
    streamController.addStream(_conversationService.GetMessages());
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: streamController.stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return WidgetHelper.loading(Colors.green);
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  return (snapshot.hasData) ? _list(snapshot) : _noItems();
                  break;
              }
            }));
  }

  Widget _noItems() => Container(
      height: 50,
      child: Center(
          child: Text("Você não tem nenhum contato.",
              textAlign: TextAlign.center)));

  Widget _list(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<ConversationModel> conversationList = snapshot.data.documents
        .map((item) => ConversationModel.fromJson(item.data))
        .toList();

    return ListView.separated(
        itemBuilder: (context, index) => _itemList(conversationList[index]),
        separatorBuilder: (context, index) =>
            Divider(height: 2, color: Colors.grey),
        itemCount: conversationList.length);
  }

  Widget _itemList(ConversationModel conversationModel) {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, "/chat",
            arguments: conversationModel.user),
        child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            leading: CircleAvatar(
                maxRadius: 30,
                backgroundColor: Colors.grey,
                backgroundImage: (conversationModel.urlImage == null)
                    ? AssetImage('assets/images/contacts/no-img.png')
                    : NetworkImage(conversationModel.urlImage)),
            title: Text(conversationModel.user.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(conversationModel.message)));
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:whatsapp/global/main_global.dart';
import 'package:whatsapp/global/main_theme.dart';
import 'package:whatsapp/global/theme_widge.dart';
import 'package:whatsapp/helper/widget_helper.dart';
import 'package:whatsapp/services/conversation_service.dart';
import 'package:whatsapp/services/message_service.dart';
import 'package:whatsapp/services/model/message_model.dart';
import 'package:whatsapp/services/model/user_model.dart';
import 'package:whatsapp/services/storage_service.dart';
import 'package:whatsapp/theme/component_helper.dart';
import 'package:image_picker/image_picker.dart';

class Chat extends StatefulWidget {
  UserModel userModel;

  Chat(this.userModel);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  MessageService _messageService;
  StorageService _storageService;
  ConversationService _conversationService;

  TextEditingController _messageController = TextEditingController();
  ScrollController _listController = ScrollController();

  bool _loadUploadImage = false;

  _ChatState() {
    _messageService = MessageService();
    _conversationService = ConversationService();
    _storageService = StorageService("mensagens");
  }

  _sendMessage() {
    if (_messageController.text.isEmpty) return;
    String message = _messageController.text;
    _messageService.SendMessage(
            widget.userModel.uid, MessageModel.Send(message, "", "text"))
        .then((onValue) {
      _conversationService.SaveLastConversation(widget.userModel, message);
    });
    _messageController.clear();
  }

  _sendImage() async {
    setState(() {
      _loadUploadImage = true;
    });

    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    _storageService.SetFileInFolder(
            file,
            DateTime.now().millisecondsSinceEpoch.toString() + ".jpg",
            MainGlobal.userModel.uid)
        .onComplete
        .then((StorageTaskSnapshot snapshot) async {
      _messageService.SendMessage(
              widget.userModel.uid,
              MessageModel.Send(
                  "", await snapshot.ref.getDownloadURL(), "image"))
          .then((_) {
        setState(() {
          _loadUploadImage = false;
        });
        _listScrollEnd();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover)),
            child: SafeArea(
                child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(children: [_messages(), _inputChat()])))));
  }

  Widget _appBar() {
    return AppBar(
        title: Row(children: [
          Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: Colors.grey,
                  backgroundImage: (widget.userModel.urlImage == null)
                      ? AssetImage('assets/images/contacts/no-img.png')
                      : NetworkImage(widget.userModel.urlImage))),
          Text(widget.userModel.name)
        ]),
        elevation: MainTheme.elevation);
  }

  Widget _messages() {
    return StreamBuilder(
        stream: _messageService.GetMessages(widget.userModel.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return WidgetHelper.loading(Colors.green);
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError)
                return Expanded(child: Text("Erro ao carregar os dados!"));

              if (!snapshot.hasData)
                return Expanded(child: Text("Sem conversa"));

              List<DocumentSnapshot> documents =
                  snapshot.data.documents.toList();

              return _listMessage(documents
                  .map((json) => MessageModel.fromJson(json.data))
                  .toList());

              break;
          }
        });
  }

  _listScrollEnd() {
    _listController.animateTo(_listController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 10), curve: Curves.easeOut);
  }

  Widget _listMessage(List<MessageModel> messages) {
    SchedulerBinding.instance.addPostFrameCallback((_) => _listScrollEnd());

    return Expanded(
        child: ListView.builder(
            controller: _listController,
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) =>
                (messages[index].uidUser == MainGlobal.userModel.uid)
                    ? _boxMessgeSent(messages[index])
                    : _boxMessgeReceived(messages[index])));
  }

  Widget _boxMessgeSent(MessageModel message) =>
      _boxMessge(message, Alignment.centerRight, MainTheme.messageSentColor);

  Widget _boxMessgeReceived(MessageModel message) =>
      _boxMessge(message, Alignment.centerLeft, MainTheme.messageReceived);

  Widget _boxMessge(MessageModel message, alignment, color) {
    return Align(
        alignment: alignment,
        child: Padding(
            padding: EdgeInsets.all(6),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: message.type == "text"
                    ? Text(message.message, style: TextStyle(fontSize: 18))
                    : Image.network(message.urlImage))));
  }

  Widget _inputChat() {
    return Container(
        padding: EdgeInsets.all(8),
        child: Row(children: [
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ComponentHelper.InputFieldCircular(
                      "Digite uma mensagem... ", TextInputType.emailAddress,
                      controller: _messageController,
                      autofocus: true,
                      contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                      prefixIcon: _loadUploadImage
                          ? CircularProgressIndicator()
                          : IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: _sendImage))) //
              ),
          ThemeWidget.sendButton("Enviar", _sendMessage)
        ]));
  }
}

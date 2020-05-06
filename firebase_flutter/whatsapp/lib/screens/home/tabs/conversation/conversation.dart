import 'package:flutter/material.dart';
import '../tab_base.dart';

class Conversation extends TabBase {
  @override
  String Title = "Conversas";

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, indice) {
          return ListTile(
              contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      AssetImage('assets/images/contacts/perfil1.jpg')),
              title: Text('Sun', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('93 million miles away'));
        });
  }
}

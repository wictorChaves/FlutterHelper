import 'package:flutter/material.dart';
import '../tab_base.dart';

class Contact extends TabBase {
  @override
  String Title = "Contatos";

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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

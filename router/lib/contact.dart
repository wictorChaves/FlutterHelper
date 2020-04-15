import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact")),
      body: Container(
        child: RaisedButton(
            child: Text("Home"),
            onPressed: (){
              Navigator.pushNamed(context, "/");
            }
        ),
      ),
    );
  }
}

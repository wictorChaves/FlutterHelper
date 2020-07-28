import 'package:flutter/material.dart';

class Basic1Animation extends StatefulWidget {
  @override
  _Basic1AnimationState createState() => _Basic1AnimationState();
}

class _Basic1AnimationState extends State<Basic1Animation> {
  bool _status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedContainer(
            duration: Duration(seconds: 1),
            color: Colors.green,
            padding: EdgeInsets.all(10),
            height: _status ? 0 : 100),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            elevation: 6,
            child: Icon(Icons.add_box),
            onPressed: () {
              setState(() {
                _status = !_status;
              });
            }));
  }
}

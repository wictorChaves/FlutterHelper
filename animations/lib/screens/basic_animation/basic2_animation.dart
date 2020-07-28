import 'package:flutter/material.dart';

class Basic2Animation extends StatefulWidget {
  @override
  _Basic2AnimationState createState() => _Basic2AnimationState();
}

class _Basic2AnimationState extends State<Basic2Animation> {
  bool _status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedContainer(
            duration: Duration(seconds: 1),
            color: Colors.green,
            padding: EdgeInsets.only(bottom: 100, top: 20),
            alignment: _status ? Alignment.bottomCenter : Alignment.topCenter,
            child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: _status ? 1 : 0,
                child: Container(
                    height: 50,
                    child: Icon(
                      Icons.airplanemode_active,
                      size: 50,
                      color: Colors.white,
                    )))),
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

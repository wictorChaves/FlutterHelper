import 'package:flutter/material.dart';

class Basic3Animation extends StatefulWidget {
  @override
  _Basic3AnimationState createState() => _Basic3AnimationState();
}

class _Basic3AnimationState extends State<Basic3Animation> {
  bool _status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    _status = !_status;
                  });
                },
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                    alignment: Alignment.center,
                    width: _status ? 60 : 160,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    child: Stack(children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: AnimatedOpacity(
                              duration: Duration(milliseconds: 100),
                              opacity: _status ? 1 : 0,
                              child: Icon(
                                Icons.person_add,
                                color: Colors.white,
                              ))),
                      Align(
                          alignment: Alignment.center,
                          child: AnimatedOpacity(
                              duration: Duration(milliseconds: 100),
                              opacity: _status ? 0 : 1,
                              child: Text(
                                "Mensagem",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )))
                    ])))));
  }
}

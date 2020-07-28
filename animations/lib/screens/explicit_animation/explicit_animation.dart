import 'package:flutter/material.dart';

class ExplicitAnimation extends StatefulWidget {
  @override
  _ExplicitAnimationState createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  AnimationStatus _animationStatus;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this)
          ..repeat()
          ..addStatusListener((status) {
            _animationStatus = status;
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: Column(children: <Widget>[
              Container(
                  width: 300,
                  height: 400,
                  child: RotationTransition(
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/logo.png"),
                      turns: _animationController)),
              RaisedButton(
                  child: Text("Pressione"),
                  onPressed: () {
                    if (_animationStatus == AnimationStatus.dismissed) {
                      _animationController.repeat();
                    } else {
                      _animationController.reverse();
                    }
                  })
            ])));
  }
}

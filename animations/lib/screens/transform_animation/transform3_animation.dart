import 'package:flutter/material.dart';

class Transform3Animation extends StatefulWidget {
  @override
  _Transform3AnimationState createState() => _Transform3AnimationState();
}

class _Transform3AnimationState extends State<Transform3Animation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    return Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: AnimatedBuilder(
            animation: _animation,
            child: Stack(children: <Widget>[
              Positioned(
                width: 180,
                height: 180,
                left: 0,
                top: 0,
                child: Image.asset("assets/images/logo.png"),
              )
            ]),
            builder: (context, widget) {
              return Transform.rotate(
                angle: _animation.value,
                child: widget,
              );
            }));
  }
}

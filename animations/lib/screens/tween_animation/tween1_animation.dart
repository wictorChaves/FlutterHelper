import 'package:flutter/material.dart';

class Tween1Animation extends StatefulWidget {
  @override
  _Tween1AnimationState createState() => _Tween1AnimationState();
}

class _Tween1AnimationState extends State<Tween1Animation> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TweenAnimationBuilder(
            duration: Duration(seconds: 5),
            tween: Tween<double>(begin: 0, end: 6.28),
            builder: (BuildContext context, double angulo, Widget widget) {
              return Transform.rotate(
                  angle: angulo, child: Image.asset("assets/images/logo.png"));
            }));
  }
}

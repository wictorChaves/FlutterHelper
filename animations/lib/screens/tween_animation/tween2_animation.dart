import 'package:flutter/material.dart';

class Tween2Animation extends StatefulWidget {
  @override
  _Tween2AnimationState createState() => _Tween2AnimationState();
}

class _Tween2AnimationState extends State<Tween2Animation> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TweenAnimationBuilder(
            duration: Duration(seconds: 1),
            tween: Tween<double>(begin: 50, end: 180),
            builder: (BuildContext context, double largura, Widget widget) {
              return Container(color: Colors.green, width: largura, height: 60);
            }));
  }
}

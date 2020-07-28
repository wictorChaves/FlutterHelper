import 'package:flutter/material.dart';

class Tween3Animation extends StatefulWidget {
  @override
  _Tween3AnimationState createState() => _Tween3AnimationState();
}

class _Tween3AnimationState extends State<Tween3Animation> {

  static final colorTween = ColorTween(begin: Colors.white, end: Colors.orange);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TweenAnimationBuilder(
            duration: Duration(seconds: 2),
            tween: colorTween,
            child: Image.asset("assets/images/estrelas.jpg"),
            builder: (BuildContext context, Color cor, Widget widget) {
              return ColorFiltered(
                  colorFilter: ColorFilter.mode(cor, BlendMode.overlay),
                  child: widget);
            }));
  }
}

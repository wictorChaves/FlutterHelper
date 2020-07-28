import 'package:animations/screens/basic_animation/basic1_animation.dart';
import 'package:animations/screens/basic_animation/basic2_animation.dart';
import 'package:animations/screens/basic_animation/basic3_animation.dart';
import 'package:animations/screens/explicit_animation/explicit_animation.dart';
import 'package:animations/screens/implicit_animation/implicit_animation.dart';
import 'package:animations/screens/transform_animation/transform1_animation.dart';
import 'package:animations/screens/transform_animation/transform2_animation.dart';
import 'package:animations/screens/transform_animation/transform3_animation.dart';
import 'package:animations/screens/tween_animation/tween1_animation.dart';
import 'package:animations/screens/tween_animation/tween2_animation.dart';
import 'package:animations/screens/tween_animation/tween3_animation.dart';
import 'package:flutter/material.dart';

class RouteContent extends StatefulWidget {
  String current_route;

  RouteContent(this.current_route);

  @override
  _RouteContentState createState() => _RouteContentState();
}

class _RouteContentState extends State<RouteContent> {
  @override
  Widget build(BuildContext context) {
    switch (widget.current_route) {
      case 'implicit':
        return ImplicitAnimation();
      case 'explicit':
        return ExplicitAnimation();
      case 'basic1':
        return Basic1Animation();
      case 'basic2':
        return Basic2Animation();
      case 'basic3':
        return Basic3Animation();
      case 'tween1':
        return Tween1Animation();
      case 'tween2':
        return Tween2Animation();
      case 'tween3':
        return Tween3Animation();
      case 'transform1':
        return Transform1Animation();
      case 'transform2':
        return Transform2Animation();
      case 'transform3':
        return Transform3Animation();
      default:
        return Container(child: Text("Página não encontrada"));
    }
  }
}

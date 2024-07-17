
import 'package:flutter/material.dart';

class FullDialogRoute<T> extends PageRoute<T> {
  FullDialogRoute({required this.builder}) : super();

  final WidgetBuilder builder;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String get barrierLabel => 'Close';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration =>const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    var curveTween = CurveTween(curve: Curves.easeInOut);

    var tween = Tween(begin: begin, end: end).chain(curveTween);
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }
}
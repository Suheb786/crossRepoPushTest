import 'package:flutter/material.dart';

class CustomRoute {
  static Route createRoute(Widget Page, {bool? reverse = false}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin = reverse! ? Offset(0.0, 0.0) : Offset(0.0, 1.0);
        Offset end = reverse ? Offset.zero : Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

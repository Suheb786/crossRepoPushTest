import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppTiltCard extends StatelessWidget {
  final int? pageViewIndex;
  final int? currentPage;
  final Widget? child;

  AppTiltCard(
      {required this.pageViewIndex,
      required this.currentPage,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: pageViewIndex! == currentPage! ? 1 : 1,
      duration: Duration(milliseconds: 500),
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 8),
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        transformAlignment: Alignment.center,
        transform: Matrix4.rotationZ(pageViewIndex! == currentPage!
            ? 0
            : pageViewIndex! < currentPage!
                ? -2 * (math.pi / 180)
                : 2 * (math.pi / 180)),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          transform: Matrix4.diagonal3Values(
              pageViewIndex! == currentPage! ? 1 : 1,
              pageViewIndex! == currentPage! ? 1 : 1,
              1.0),
          transformAlignment: Alignment.center,
          curve: Curves.easeIn,
          margin: EdgeInsets.only(
              bottom: pageViewIndex! == currentPage! ? 5 : 0,
              top: pageViewIndex! == currentPage! ? 0 : 5),
          child: child!,
        ),
      ),
    );
  }
}

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
      duration: Duration(milliseconds: 300),
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 10),
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        transformAlignment: Alignment.center,
        transform: Matrix4.rotationZ(pageViewIndex! == currentPage!
            ? 0
            : pageViewIndex! < currentPage!
                ? -0.03
                : 0.03),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          transform: Matrix4.diagonal3Values(
              pageViewIndex! == currentPage! ? 1 : 1,
              pageViewIndex! == currentPage! ? 1 : 1,
              1.0),
          transformAlignment: Alignment.center,
          curve: Curves.easeIn,
          margin:
              EdgeInsets.only(bottom: pageViewIndex! == currentPage! ? 5 : 0),
          child: child!,
        ),
      ),
    );
  }
}
